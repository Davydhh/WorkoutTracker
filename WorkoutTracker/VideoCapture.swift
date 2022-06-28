import Foundation
import AVFoundation

class VideoCapture {
    let captureSession = AVCaptureSession()
    
    init() {
        guard let captureDevice = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }
        
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        captureSession.addInput(input)
    }
    
    func startCaptureSession() {
        captureSession.startRunning()
    }
}
