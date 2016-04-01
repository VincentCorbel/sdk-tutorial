//
//  ViewController.m
//  Notification
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "ViewControllerBeacon.h"

@interface ViewControllerBeacon ()

@end

@implementation ViewControllerBeacon
@synthesize txtMessage,messageString;

- (void)viewDidLoad {
    [super viewDidLoad];
    if(messageString.length ==0 || nil){
        messageString = NSLocalizedString(@"beacon_content_empty", @"");
    }
        // Do any additional setup after loading the view, typically from a nib.
   }
-(void)viewWillAppear:(BOOL)animated{
  self.txtMessage.text = messageString;
}
 //Method to retreive notification BeaconContent from the AppDelegate
 -(void) load:(ATBeaconContent *)_beaconContent redirectType:(ATBeaconRedirectType)_redirectType from:(NSString *)_from{
     messageString = [_beaconContent getNotificationTitle];
     //[self performSelectorOnMainThread:@selector(updateView) withObject:nil waitUntilDone:YES];
}

//update view with beaconContent
-(void)updateView {
    [self.txtMessage setText:messageString];
    [self.txtMessage setNeedsDisplay];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
