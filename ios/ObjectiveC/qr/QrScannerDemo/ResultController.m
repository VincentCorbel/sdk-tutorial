//
//  ResultController.m
//  QrScannerDemo
//
//  Created by Sarra Srairi on 16/06/2015.
//  Copyright (c) 2015 ct. All rights reserved.
//

#import "ResultController.h"

@interface ResultController ()

@end

@implementation ResultController
@synthesize resultInformation;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGSize viewSize = self.view.bounds.size;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
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
    UIView * centerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewSize.width-90, viewSize.height/5)];
    centerView.center = self.view.center;
    [centerView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    [self.view addSubview:centerView];
    CGSize viewCenterSize =  centerView.bounds.size;
    
    // version Label
    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(centerView.frame.origin.x +40 ,centerView.frame.origin.y ,  viewCenterSize.width- 10 , 50)];
    
    version.text = @"QrCode Information";
    [version setTextColor: [UIColor whiteColor]];
    [self.view addSubview: version];
    
    // static Label 1
    UILabel *resultTextInformation = [[UILabel alloc]initWithFrame:CGRectMake(0,0,   130 , 50)];
    ATAdtagContent * content = self.resultInformation ;
    resultTextInformation.numberOfLines = 0;
    resultTextInformation.text = [content getValueFromCategory:@"Name" andField:@"Nom"];
    [resultTextInformation setFont: [UIFont fontWithName:@"Helvetica" size:14.0f]];
    resultTextInformation.center = centerView.center;
    [resultTextInformation setTextColor: [UIColor whiteColor]];
    [self.view addSubview: resultTextInformation];
    
    //back button
    UIImage *btnInformation = [UIImage imageNamed:@"ico-next.png"];
    self.backbtn = [[UIButton alloc] initWithFrame:CGRectMake(0,viewSize.height-50 ,  btnInformation.size.width, btnInformation.size.height)];
    [self.backbtn setImage:btnInformation forState:UIControlStateNormal];
    [self.backbtn addTarget:self
                     action:@selector(back)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.backbtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) back {
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (id)initWithResult:(ATAdtagContent*)result{
    self = [super init];
    if (self) {
        self.resultInformation = result ;
        NSLog(@"result %@",result);
 
        adTagLogContent = [[ATAdtagLogContent alloc] initWihAdtagContent:result subType:ATLogSubtypeRedirect from:@"ResultController"];
        logManager = [[ATLogManager alloc] init];
        [logManager sendLog:adTagLogContent];
    }
    return self;
}
@end
