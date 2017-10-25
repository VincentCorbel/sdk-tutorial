//
//  ResultController.h
//  QrScannerDemo
//
//  Created by Sarra Srairi on 16/06/2015.
//  Copyright (c) 2015 ct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATConnectionHttp/ATConnectionHttp.h>
#import <ATAnalytics/ATAnalytics.h>
@interface ResultController : UIViewController {
    ATAdtagContent  *resultInformation;
    ATAdtagLogContent * adTagLogContent;
    ATLogManager *logManager ;
    
}


@property (strong, nonatomic) ATAdtagContent  *resultInformation;

- (id)initWithResult:(ATAdtagContent*)resultContent andTechnology:(NSString *) technology;
@property (strong, nonatomic) IBOutlet UIButton *backbtn;
@end
