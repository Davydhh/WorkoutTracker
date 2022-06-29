//
//  CameraViewController.swift
//  WorkoutTracker
//
//  Created by utente on 28/06/22.
//

import UIKit
import AVFoundation
import AudioToolbox

class CameraViewController: UIViewController {
    
    let videoCapture = VideoCapture()
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var pointsLayer = CAShapeLayer()
    
    var isPullUpDetected = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVideopreview()
        
        videoCapture.predictor.delegate = self
    }
    

    func setUpVideopreview() {
        videoCapture.startCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captureSession)
        
        guard let previewLayer = previewLayer else { return }
        
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        view.layer.addSublayer(pointsLayer)
        pointsLayer.frame = view.frame
        pointsLayer.strokeColor = UIColor.blue.cgColor
    }
}

extension CameraViewController: PredictorDelegate {
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        print(action, confidence)
//        if action == "pull up" && confidence > 0.7 && isPullUpDetected == false {
//            print("Pull up detected")
//            isPullUpDetected = true
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                self.isPullUpDetected = false
//            }
//
//            DispatchQueue.main.async {
//                AudioServicesPlayAlertSound(SystemSoundID(1322))
//            }
//        }
    }
    
    func predictor(_ predictor: Predictor, didFunfNewREcongizedPoints points: [CGPoint]) {
        guard let previewLayer = previewLayer else { return }
        
        let convertedPoints = points.map {
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        
        let combinePath = CGMutablePath()
        
        for point in convertedPoints {
            let doPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
            combinePath.addPath(doPath.cgPath)
        }
        
        pointsLayer.path = combinePath
        
        DispatchQueue.main.async {
            self.pointsLayer.didChangeValue(for: \.path)
        }
    }
}
