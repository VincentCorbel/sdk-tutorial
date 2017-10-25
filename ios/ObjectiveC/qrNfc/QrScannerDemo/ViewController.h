//
//  ViewController.h
//  QrScannerDemo
//
//  Created by Sarra Srairi on 15/06/2015.
//  Copyright (c) 2015 ct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATQrNfc/ATQrNfc.h>
#import "infoController.h"
#import "ResultController.h"
#import "QrCodeScanner.h"

@interface ViewController : UIViewController <ATContentReceiver, ATNfcReceiver>{
    ATContentAsker *contentAsker;
    QrCodeScanner *qrCodeScanner;
    ATNfcReader *nfcReader;
}


@property (strong, nonatomic) IBOutlet UIButton *buttonInfo;
@property (strong, nonatomic) IBOutlet UIButton *buttonQrCodeReader;
@property (strong, nonatomic) IBOutlet UIButton *buttonNfcTagReader;
@property (strong, nonatomic) IBOutlet UITextView *tvNfcError;

@end

