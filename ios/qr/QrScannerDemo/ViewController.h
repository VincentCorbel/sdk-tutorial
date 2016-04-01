//
//  ViewController.h
//  QrScannerDemo
//
//  Created by Sarra Srairi on 15/06/2015.
//  Copyright (c) 2015 ct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATConnectionHttp/ATConnectionHttp.h>
#import <ATSdkAdtagContent/ATSdkAdtagContent.h>
#import "infoController.h"
#import "ResultController.h"
#import "QrCodeScanner.h"

@interface ViewController : UIViewController <ATContentReceiver>{
    ATContentAsker *contentAsker;
    QrCodeScanner *scanner;
}


@property (strong, nonatomic) IBOutlet UIButton *scanbtn;
@property (strong, nonatomic) IBOutlet UIButton *infobtn;
@property (strong, nonatomic) IBOutlet UIButton *fromLabel;
 
@end

