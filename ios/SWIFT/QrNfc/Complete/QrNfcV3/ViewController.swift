//
//  ViewController.swift
//  QrNfcV3
//
//  Created by Connecthings on 29/09/2017.
//  Copyright © 2017 Connecthings. All rights reserved.
//

import UIKit
import AdtagConnection
import AdtagScanProximity
import ConnectPlaceCommon
import AVFoundation

class ViewController: UIViewController, AdtagScanProximityDelegate, ProximityHealthCheckDelegate {
    @IBOutlet weak var tvContentError: UITextView!
    @IBOutlet weak var btnNfcReader: UIButton!
    @IBOutlet weak var btnQrCode: UIButton!
    
    let adtagInitializer: AdtagInitializer = AdtagInitializer.shared
    let adtagScanProximityManager: AdtagScanProximityManager = AdtagScanProximityManager.shared
    var adtagQrCodeReader: AdtagQrCodeReader?
    var adtagNfcReader: AdtagNfcReader?

    override func viewDidLoad() {
        super.viewDidLoad()
        adtagQrCodeReader = AdtagQrCodeReader(controller: self, cancelLabel: "Cancel")
        adtagQrCodeReader?.readerVC
        adtagNfcReader = AdtagNfcReader(message: "Read NFC TAG")
        btnNfcReader.isHidden = !NfcUtils.isReadingNfcTagSupported()
        btnQrCode.isHidden = adtagQrCodeReader!.isCameraAccessDenied()
    }

    override func viewWillAppear(_ animated: Bool) {
        adtagScanProximityManager.scanProximityDelegate = self
        adtagInitializer.registerProximityHealthCheckDelegate(self)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        adtagScanProximityManager.scanProximityDelegate = nil
        adtagInitializer.unregisterProximityHealthCheckDelegate(self)
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openQrCodeReader(_ sender: Any) {
        adtagQrCodeReader?.start()
    }
    
    @IBAction func openNfcReader(_ sender: Any) {
        adtagNfcReader?.start()
    }

    func onScanProximityContentDownloadInProgress() {
        tvContentError.text = "Waiting for content result..."
    }

    func onScanProximityContent(placeInAppAction: AdtagPlaceInAppAction?) {
        if let placeInAppAction = placeInAppAction {
            tvContentError.text = placeInAppAction.adtagContent!.getValue(categoryName: "Name", fieldName: "Nom")
        } else {
            tvContentError.text = "No content associated to the tag"
        }
    }

    func onProximityHealthCheckUpdate(_ healthStatus: HealthStatus) {
        var errorMsg: String = ""
        if healthStatus.isDown {
            for serviceStatus in healthStatus.serviceStatusMap.values {
                if serviceStatus.isDown() {
                    for status in serviceStatus.statusList {
                        errorMsg += status.message as String + "\n"
                    }
                }
            }
         }
        tvContentError.text = errorMsg
    }

}

