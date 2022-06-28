//
//  CameraViewController.swift
//  WorkoutTracker
//
//  Created by utente on 28/06/22.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    let videoCapture = VideoCapture()
    
    var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVideopreview()
    }
    

    func setUpVideopreview() {
        videoCapture.startCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captureSession)
        
        guard let previewLayer = previewLayer else { return }
        
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
    }

}
