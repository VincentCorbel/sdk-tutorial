//
//  infoController.m
//  QrScannerDemo
//
//  Created by Sarra Srairi on 16/06/2015.
//  Copyright (c) 2015 ct. All rights reserved.
//

#import "infoController.h"

@interface infoController ()

@end

@implementation infoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // clear Color navirgation Controller
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
    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(centerView.frame.origin.x +5 ,centerView.frame.origin.y +10,  viewCenterSize.width- 10 , 50)];
    
    version.text = @"Version de l'application : 1.0";
    [version setTextColor: [UIColor whiteColor]];
    [self.view addSubview: version];
    
    // static Label 1
    UILabel *StaticText = [[UILabel alloc]initWithFrame:CGRectMake(0,0,   130 , 50)];
    StaticText.center = centerView.center;
    StaticText.text = @"Developped by :";
    [StaticText setTextColor: [UIColor whiteColor]];
    [self.view addSubview: StaticText];
    
    // static Label 2
    UILabel *staticText2 = [[UILabel alloc]initWithFrame:CGRectMake(StaticText.frame.origin.x+10,StaticText.frame.origin.y +25,   120 , 50)];
    
    staticText2.text = @"Connecthings";
    [staticText2 setTextColor: [UIColor whiteColor]];
    [self.view addSubview: staticText2];

    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) back {
 [self.navigationController popViewControllerAnimated:YES];
}
@end
