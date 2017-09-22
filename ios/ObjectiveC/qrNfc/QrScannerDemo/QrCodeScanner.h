//
//  QrCodeScanner.h
//  ATQR
//
//  Created by Sarra Srairi on 05/06/2015.
//  Copyright (c) 2015 ct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <ATQrNfc/ATQrNfc.h>
#import <UIKit/UIKit.h>
@interface QrCodeScanner : NSObject <AVCaptureMetadataOutputObjectsDelegate>{
    NSObject *qrCodeScannerDelegateLock;
    id<ATQrCodeScannerDelegate> qrCodeScannerDelegate;
}
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL isReading;


@property (strong, nonatomic) IBOutlet UIView *viewPreview;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
 
-(void) registerQrCodeScannerDelegate:(__autoreleasing id<ATQrCodeScannerDelegate>)_qrCodeScannerDelegate;


-(id)init;
-(BOOL)startReading;
-(void)stopReading;
-(void)loadBeepSound;
-(void)setUpScanner ;
@end
