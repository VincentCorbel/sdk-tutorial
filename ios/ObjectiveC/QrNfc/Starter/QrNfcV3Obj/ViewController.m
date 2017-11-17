//
//  ViewController.m
//  QrNfcV3Obj
//
//  Created by Connecthings on 02/10/2017.
//  Copyright © 2017 Connecthings. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UITextView *textViewContent;
    @property (weak, nonatomic) IBOutlet UIButton *btnNfc;
    @property (weak, nonatomic) IBOutlet UIButton *btnQrCode;

@end

@implementation ViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

- (IBAction)openQrCodeReader:(id)sender {

}

- (IBAction)openNfcReader:(id)sender {

}

@end
