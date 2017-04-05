//
//  AlertViewControllerAction.m
//  beaconAlertComplete
//
//  Created by sarra srairi on 08/04/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AlertViewControllerAction.h"

@interface AlertViewControllerAction (){
 
}

@end

@implementation AlertViewControllerAction
@synthesize alertBeaconContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.txtdescription.text = [alertBeaconContent getAlertDescription];
    
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

@end
