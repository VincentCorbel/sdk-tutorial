//
//  ViewController.m
//  QrScannerDemo
//
//  Created by Sarra Srairi on 15/06/2015.
//  Copyright (c) 2015 ct. All rights reserved.
//

#import "ViewController.h"
#define kBoarderWidth 3.0
#define kCornerRadius 9.0
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     * Init the contentAsker / the contentAsker is shared between the QrCodeScanner and the NfcReader
     **/
    contentAsker = [ATContentAsker sharedInstance];
    //The QrCodeScanner is not part of the ATQrNfc framework but is part of the project.
    qrCodeScanner = [[QrCodeScanner alloc] init];
    [qrCodeScanner registerQrCodeScannerDelegate:contentAsker];
    // the ATNFCReader is part of the ATQrNfc framework
    if ([ATNfcReader isReadingNfcTagSupported]) {
        //The message is the text displays at the bottom of the NFC view
        nfcReader = [[ATNfcReader alloc] initWithContentAsker:[ATContentAsker sharedInstance] AndMessage:@"Oh Oui, flash le tag NFC Jean-No"];
    }


    CGSize viewSize = self.view.bounds.size;
    // clear Color navirgation Controller
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];

    //adding background image
    [self.view setBackgroundColor:[UIColor clearColor]];
    UIImage * img = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *imgViewBackground = [[UIImageView alloc] initWithImage: img];
    imgViewBackground.contentMode=UIViewContentModeCenter;
    CGRect viewFrame = [[self view] frame];
    [imgViewBackground setFrame:viewFrame];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview: imgViewBackground];
    
    // label
    self.buttonQrCodeReader = [[UIButton alloc]initWithFrame:CGRectMake(0,0,  150, 50)];
    [self.buttonQrCodeReader setCenter:CGPointMake(self.view.bounds.size.width/2,  75)];
    [self.buttonQrCodeReader setTitle:@"Scan QR CODE" forState:UIControlStateNormal];
    [self.buttonQrCodeReader setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    CALayer *borderLayer = [CALayer layer];
    CGRect borderFrame = CGRectMake(0, 0, (self.buttonQrCodeReader.frame.size.width), (self.buttonQrCodeReader.frame.size.height));
    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer setFrame:borderFrame];
    [borderLayer setCornerRadius:kCornerRadius];
    [borderLayer setBorderWidth:2.0];
    [borderLayer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.buttonQrCodeReader.layer addSublayer:borderLayer];
    [self.view addSubview: self.buttonQrCodeReader];
    [self.buttonQrCodeReader addTarget:self
                       action:@selector(startScan)
             forControlEvents:UIControlEventTouchUpInside];

    if (nfcReader) {
        self.buttonNfcTagReader = [[UIButton alloc]initWithFrame:CGRectMake(0,0,  150, 50)];
        [self.buttonNfcTagReader setCenter:CGPointMake(self.view.bounds.size.width/2,  150)];
        CALayer *borderLayerNfc = [CALayer layer];
        CGRect borderFrameNfc = CGRectMake(0, 0, (self.buttonNfcTagReader.frame.size.width), (self.buttonNfcTagReader.frame.size.height));
        [borderLayerNfc setBackgroundColor:[[UIColor clearColor] CGColor]];
        [borderLayerNfc setFrame:borderFrameNfc];
        [borderLayerNfc setCornerRadius:kCornerRadius];
        [borderLayerNfc setBorderWidth:2.0];
        [borderLayerNfc setBorderColor:[[UIColor whiteColor] CGColor]];
        [self.buttonNfcTagReader.layer addSublayer:borderLayerNfc];
        [self.buttonNfcTagReader setTitle:@"Scan NFC TAG" forState:UIControlStateNormal];
        [self.buttonNfcTagReader setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview: self.buttonNfcTagReader];
        [self.buttonNfcTagReader addTarget:self
                              action:@selector(startDetectingNfcTag)
                    forControlEvents:UIControlEventTouchUpInside];
    } else {
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0,0,  300, 50)];
        [textView setCenter:CGPointMake(self.view.bounds.size.width/2,  150)];
        textView.textColor = [UIColor whiteColor];
        textView.backgroundColor = [UIColor clearColor];
        textView.textAlignment = NSTextAlignmentCenter;
        textView.text = @"NFC is not supported by the phone or the iOs version";
        [self.view addSubview: textView];
    }

    _tvNfcError =  [[UITextView alloc]initWithFrame:CGRectMake(0,0,  300, 50)];
    [_tvNfcError setCenter:CGPointMake(self.view.bounds.size.width/2,  280)];
    _tvNfcError.textColor = [UIColor whiteColor];
    _tvNfcError.textAlignment = NSTextAlignmentCenter;
    _tvNfcError.backgroundColor = [UIColor clearColor];
    [self.view addSubview: _tvNfcError];
    //information button
    UIImage *btnInformation = [UIImage imageNamed:@"ico-info.png"];
    self.buttonInfo = [[UIButton alloc] initWithFrame:CGRectMake(viewSize.width - 50,viewSize.height-50 ,  btnInformation.size.width, btnInformation.size.height)];
    [self.buttonInfo setImage:btnInformation forState:UIControlStateNormal];
    [self.buttonInfo addTarget:self
                     action:@selector(infoPage)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.buttonInfo];
    

}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //******* register the delegate ***********
    [contentAsker registerAdtagContentReceiverDelegate:self];
    [nfcReader registerNfcReceiver:self];
}

- (void) viewDidDisappear:(BOOL)animated {
    //*********** unregister the delegate ***********
    [contentAsker registerAdtagContentReceiverDelegate:nil];
    [nfcReader registerNfcReceiver:nil];
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onReceiveAdtagContent:(ATAdtagContent *)content
                   feedStatus:(ATFeedStatus)feedStatus
                   technology:(NSString *)technology {
    /**
     * ********* Do Action depending of the feed status ************
     **/
    if (feedStatus == ATFeedStatusBackendSuccess) {
        ResultController *resultControl = [[ResultController alloc]  initWithResult:content andTechnology:technology];
        [self.navigationController pushViewController:resultControl animated:YES];
    }else if(feedStatus == ATFeedStatusInProgress){
        NSLog(@"start to connect to server to get data");
    }else{
        NSLog(@"error while connecting to the server");
    }
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 

- (void) startScan {
    //******* Launch the QrCodeScanner *********
    [qrCodeScanner setUpScanner];
}

- (void) startDetectingNfcTag {
    _tvNfcError.text = @"";
    [_tvNfcError setNeedsDisplay];
    //Launch the nfc reader
    [nfcReader startReader];
}

/**
 * ****** 3 methods to inform the user about an error with the NFC *******
 **/
- (void) onNfcReadingNotSupported {
    _tvNfcError.text = @"The NFC is not supported by your phone or the iOs version";
    [_tvNfcError setNeedsDisplay];
}

- (void) onReadingNfcError {
    _tvNfcError.text = @"The application meets an error while reading the tag. Please try again.";
    [_tvNfcError setNeedsDisplay];
}

- (void) onParseNfcFormatNotSupported {
    _tvNfcError.text = @"The NFC Tag does not contain any relevant url";
    [_tvNfcError setNeedsDisplay];
}

-(void) infoPage {
    infoController *infoControl = [[infoController alloc]  init];
    [self.navigationController pushViewController:infoControl animated:YES];
}

@end
