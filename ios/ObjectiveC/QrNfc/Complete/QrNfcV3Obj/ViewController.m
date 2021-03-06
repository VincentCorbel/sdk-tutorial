//
//  ViewController.m
//  QrNfcV3Obj
//
//  Created by Connecthings on 02/10/2017.
//  Copyright © 2017 Connecthings. All rights reserved.
//

#import "ViewController.h"
@import AdtagScanProximity;

@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UITextView *textViewContent;
    @property (weak, nonatomic) IBOutlet UIButton *btnNfc;
@property (weak, nonatomic) IBOutlet UIButton *btnQrCode;

@end

@implementation ViewController {
    AdtagScanProximityManager *adtagScanProximityManager;
    AdtagInitializer *adtagInitializer;
    AdtagQrCodeReader *qrCodeReader;
    AdtagNfcReader *nfcReader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    adtagInitializer = [AdtagInitializer shared];
    adtagScanProximityManager = [AdtagScanProximityManager shared];
    qrCodeReader = [[AdtagQrCodeReader alloc] initWithController:self cancelLabel:@"Cancel"];
    nfcReader = [[AdtagNfcReader alloc] initWithMessage:@"Read NFC TAG"];
    [_btnNfc setHidden:![NfcUtils isReadingNfcTagSupported]];
    [_btnQrCode setHidden:[qrCodeReader isCameraAccessDenied]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    adtagScanProximityManager.scanProximityDelegate = self;
    [adtagInitializer registerProximityHealthCheckDelegate:self];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     adtagScanProximityManager.scanProximityDelegate = nil;
    [adtagInitializer unregisterProximityHealthCheckDelegate:self];
}

- (IBAction)openQrCodeReader:(id)sender {
    [qrCodeReader start];
}

- (IBAction)openNfcReader:(id)sender {
    [nfcReader start];
}

- (void)onScanProximityContentDownloadInProgress {
    _textViewContent.text = @"Download in progress";
}

- (void)onScanProximityContentWithPlaceInAppAction:(AdtagPlaceInAppAction *)placeInAppAction {
    if (placeInAppAction == nil) {
        _textViewContent.text = @"No content found associated to the tag";
    } else {
        _textViewContent.text = [[placeInAppAction adtagContent] getValueWithCategoryName:@"Name" fieldName:@"Nom"];
    }
}

- (void) onProximityHealthCheckUpdate:(HealthStatus *)healthStatus {
    NSMutableString *errorMsg = [[NSMutableString alloc] initWithString:@""];
    if ([healthStatus isDown]) {
        for (ServiceStatus *serviceStatus in healthStatus.serviceStatusMap.allValues) {
            if ([serviceStatus isDown]) {
                for (Status *status in serviceStatus.statusList) {
                    [errorMsg appendString:status.message];
                    [errorMsg appendString:@"\n"];
                }
            }
        }
    }
    _textViewContent.text = errorMsg;
}


@end
