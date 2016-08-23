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
    
  //  CGSize viewSize = self.view.bounds.size;
    CGSize viewSize = self.view.bounds.size;
    contentAsker = [[ATContentAsker alloc] init];
    [contentAsker registerAdtagContentReceiverDelegate:self];
    scanner = [[QrCodeScanner alloc] init];
    [scanner registerQrCodeScannerDelegate:contentAsker];
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
    CALayer *borderLayer = [CALayer layer];
    CGRect borderFrame = CGRectMake(0, 0, (centerView.frame.size.width), (centerView.frame.size.height));
    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer setFrame:borderFrame];
    [borderLayer setCornerRadius:kCornerRadius];
    [borderLayer setBorderWidth:2.0];
    [borderLayer setBorderColor:[[UIColor whiteColor] CGColor]];
    [centerView.layer addSublayer:borderLayer];
    [self.view addSubview:centerView];
    
    // label
    self.fromLabel = [[UIButton alloc]initWithFrame:CGRectMake(0,0,  150, 50)];
    self.fromLabel.center = self.view.center;
    [self.fromLabel setTitle:@"Scan QR CODE" forState:UIControlStateNormal];
    [self.fromLabel setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview: self.fromLabel];
    
    // Button Scanning
    UIImage *btnScan = [UIImage imageNamed:@"ico-arrow.png"];
    self.scanbtn = [[UIButton alloc] initWithFrame:CGRectMake(viewSize.width - 80 ,(viewSize.height /2) -10,  btnScan.size.width, btnScan.size.height)];
    [self.scanbtn setImage:btnScan forState:UIControlStateNormal];
    [self.fromLabel addTarget:self
                     action:@selector(startScan)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.scanbtn];
    
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
                   feedStatus:(ATFeedStatus)feedStatus{
    if (feedStatus == ATFeedStatusBackendSuccess) {
        ResultController *resultControl = [[ResultController alloc]  initWithResult:content];
        [self.navigationController pushViewController:resultControl animated:YES];
    }else if(feedStatus == ATFeedStatusInProgress){
        NSLog(@"start to connect to server to get data");
    }else{
        NSLog(@"error while connecting to the server");
    }
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 

- (void)startScan {
    [scanner setUpScanner];
}

-(void)infoPage{
    infoController *infoControl = [[infoController alloc]  init];
    [self.navigationController pushViewController:infoControl animated:YES];
}
@end
