//
//  QrCodeScanner.m
//  ATQR
//
//  Created by Sarra Srairi on 05/06/2015.
//  Copyright (c) 2015 ct. All rights reserved.
//

#import "QrCodeScanner.h"

@implementation QrCodeScanner

- (id)init
{
    self = [super init];
    if (self) {
        qrCodeScannerDelegateLock = [[NSObject alloc] init];
    }
    return self;
}

-(void)setUpScanner{
    self.viewPreview = [[UIView alloc] initWithFrame: CGRectMake ( 20, 40, 280, 350)];
    self.viewPreview.backgroundColor = [UIColor whiteColor];
    //add code to customize, e.g. polygonView.backgroundColor = [UIColor blackColor];
    self.lblStatus = [[UILabel alloc]initWithFrame:CGRectMake(20, 448,  280, 21)];
    self.lblStatus.numberOfLines = 1;
    self.lblStatus.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    self.lblStatus.adjustsFontSizeToFitWidth = YES;
    self.lblStatus.minimumScaleFactor = 10.0f/12.0f;
    self.lblStatus.clipsToBounds = YES;
    self.lblStatus.backgroundColor = [UIColor clearColor];
    self.lblStatus.textColor = [UIColor blackColor];
    self.lblStatus.textAlignment = NSTextAlignmentLeft;
    [ self.viewPreview addSubview:self.lblStatus];
    self.viewPreview.frame = [[UIScreen mainScreen] applicationFrame];
    [[[UIApplication sharedApplication] delegate].window addSubview:self.viewPreview];
       
    if (!_isReading) {
        // This is the case where the app should read a QR code when the start button is tapped.
        if ([self startReading]) {
            // If the startReading methods returns YES and the capture session is successfully
            // running, then change the start button title and the status message.
            [_lblStatus setText:@"Scanning for QR Code..."];
        }
    }
    // Set to the flag the exact opposite value of the one that currently has.
    _isReading = !_isReading;
}


- (BOOL)startReading {
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    // Start video capture.
    [_captureSession startRunning];
    
    return YES;
}

-(void) onReadingQrCode:(AVMetadataMachineReadableCodeObject *) metadataObj{
    @synchronized(qrCodeScannerDelegateLock){
        if(qrCodeScannerDelegate != nil){
            NSLog(@"%@ %@ ", qrCodeScannerDelegate,[metadataObj stringValue]);
            [qrCodeScannerDelegate onReceiveScannerResponse:[metadataObj stringValue]];
        }
    }
    [self stopReading];
}

-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
    [self.viewPreview removeFromSuperview];
 
}


-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If the audio player was successfully initialized then load it in memory.
        [_audioPlayer prepareToPlay];
    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
            [self performSelectorOnMainThread:@selector(onReadingQrCode:) withObject:metadataObj waitUntilDone:YES];
            _isReading = NO;
            // If the audio player is not nil, then play the sound effect.
            if (_audioPlayer) {
                [_audioPlayer play];
            }
        }
    }
}

-(void) registerQrCodeScannerDelegate:(__autoreleasing id<ATQrCodeScannerDelegate>)_qrCodeScannerDelegate{
    @synchronized(qrCodeScannerDelegateLock){
        qrCodeScannerDelegate = _qrCodeScannerDelegate;
    }
}
@end
