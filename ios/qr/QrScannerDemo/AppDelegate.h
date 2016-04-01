//
//  AppDelegate.h
//  QrScannerDemo
//
//  Created by Sarra Srairi on 15/06/2015.
//  Copyright (c) 2015 ct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATConnectionHttp/ATConnectionHttp.h>
#import "ViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate> {

    ATUser * user ;
    ATUrlRoot * root ;
}

@property (strong, nonatomic) UIWindow *window;


@end

