//
//  TimeAlertStrategyParameter.h
//  beaconAlertComplete
//
//  Created by Stevens Olivier on 25/08/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATConnectionHttp/ATConnectionHttp.h>

@interface TimeAlertStrategyParameter : ATBeaconAlertParameter{
    
    double lastDetectionTime;
    
    double timeToShowAlert;
}

@property double lastDetectionTime;

@property double timeToShowAlert;

@end
