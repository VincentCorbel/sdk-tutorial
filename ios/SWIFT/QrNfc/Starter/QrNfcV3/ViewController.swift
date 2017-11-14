//
//  ViewController.swift
//  QrNfcV3
//
//  Created by Connecthings on 29/09/2017.
//  Copyright © 2017 Connecthings. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var tvContentError: UITextView!
    @IBOutlet weak var btnNfcReader: UIButton!



    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openQrCodeReader(_ sender: Any) {

    }
    
    @IBAction func openNfcReader(_ sender: Any) {

    }

}

