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
    if ([ATNfcReader isReadingNfcTagSupported]) {
        nfcReader = [[ATNfcReader alloc] initWithMessage:@"Flash the NFC Tag"];
    }
    //  CGSize viewSize = self.view.bounds.size;
    CGSize viewSize = self.view.bounds.size;
    contentAsker = [ATContentAsker sharedInstance];
    [contentAsker registerAdtagContentReceiverDelegate:self];
    qrCodeScanner = [[QrCodeScanner alloc] init];
    [qrCodeScanner registerQrCodeScannerDelegate:contentAsker];
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
    
    // rectangle center
    UIView * centerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewSize.width-90, viewSize.height/7)];
    centerView.center = self.view.center;
    [centerView setBackgroundColor:[UIColor clearColor]];

    //[centerView.layer addSublayer:borderLayer];
    [self.view addSubview:centerView];
    
    // label
    self.fromLabel = [[UIButton alloc]initWithFrame:CGRectMake(0,0,  150, 50)];
    [self.fromLabel setCenter:CGPointMake(self.view.bounds.size.width/2,  75)];
    [self.fromLabel setTitle:@"Scan QR CODE" forState:UIControlStateNormal];
    [self.fromLabel setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    CALayer *borderLayer = [CALayer layer];
    CGRect borderFrame = CGRectMake(0, 0, (self.fromLabel.frame.size.width), (self.fromLabel.frame.size.height));
    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer setFrame:borderFrame];
    [borderLayer setCornerRadius:kCornerRadius];
    [borderLayer setBorderWidth:2.0];
    [borderLayer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.fromLabel.layer addSublayer:borderLayer];
    [self.view addSubview: self.fromLabel];
    [self.fromLabel addTarget:self
                       action:@selector(startScan)
             forControlEvents:UIControlEventTouchUpInside];

    if (nfcReader) {
        self.buttonNfcTag = [[UIButton alloc]initWithFrame:CGRectMake(0,0,  150, 50)];
        [self.buttonNfcTag setCenter:CGPointMake(self.view.bounds.size.width/2,  150)];
        CALayer *borderLayerNfc = [CALayer layer];
        CGRect borderFrameNfc = CGRectMake(0, 0, (self.buttonNfcTag.frame.size.width), (self.buttonNfcTag.frame.size.height));
        [borderLayerNfc setBackgroundColor:[[UIColor clearColor] CGColor]];
        [borderLayerNfc setFrame:borderFrameNfc];
        [borderLayerNfc setCornerRadius:kCornerRadius];
        [borderLayerNfc setBorderWidth:2.0];
        [borderLayerNfc setBorderColor:[[UIColor whiteColor] CGColor]];
        [self.buttonNfcTag.layer addSublayer:borderLayerNfc];
        [self.buttonNfcTag setTitle:@"Scan NFC TAG" forState:UIControlStateNormal];
        [self.buttonNfcTag setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview: self.buttonNfcTag];
        [self.buttonNfcTag addTarget:self
                              action:@selector(startDetectingNfcTag)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    //information button
    UIImage *btnInformation = [UIImage imageNamed:@"ico-info.png"];
    self.infobtn = [[UIButton alloc] initWithFrame:CGRectMake(viewSize.width - 50,viewSize.height-50 ,  btnInformation.size.width, btnInformation.size.height)];
    [self.infobtn setImage:btnInformation forState:UIControlStateNormal];
    [self.infobtn addTarget:self
                     action:@selector(infoPage)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.infobtn];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onReceiveAdtagContent:(ATAdtagContent *)content
                   feedStatus:(ATFeedStatus)feedStatus
                   technology:(NSString *)technology {
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
    [qrCodeScanner setUpScanner];
}

- (void) startDetectingNfcTag {
    [nfcReader startReader];
}

-(void)infoPage{
    infoController *infoControl = [[infoController alloc]  init];
    [self.navigationController pushViewController:infoControl animated:YES];
}
@end
