import UIKit
import AVFoundation
import AudioToolbox

final class CameraViewClass: UIView {
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
    var previewLayer: AVCaptureVideoPreviewLayer {
        layer as! AVCaptureVideoPreviewLayer
    }
}

class CameraViewController: UIViewController {
    private var cameraSession: AVCaptureSession?
    var delegate: AVCaptureVideoDataOutputSampleBufferDelegate?
    var poseEstimator: PoseEstimator?
    
    var selections: [String]?
    var exerciseReps: ExerciseRepModel?
    
    var isPullUpDetected = false
    
    private let cameraQueue = DispatchQueue(
        label: "CameraOutput",
        qos: .userInteractive
    )
    
    override func loadView() {
        view = CameraViewClass()
    }
    
    private var cameraView: CameraViewClass { view as! CameraViewClass }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        do {
            if cameraSession == nil {
                try prepareAVSession()
                cameraView.previewLayer.session = cameraSession
                cameraView.previewLayer.videoGravity = .resizeAspectFill
            }
            cameraSession?.startRunning()
        } catch {
            print(error.localizedDescription)
        }
        
        self.poseEstimator?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cameraSession?.stopRunning()
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func prepareAVSession() throws {
        let session = AVCaptureSession()
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.high
        guard let videoDevice = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .back)
        else { return }
        videoDevice.set(frameRate: 30)
        guard let deviceInput = try? AVCaptureDeviceInput(device: videoDevice)
        else { return }
        guard session.canAddInput(deviceInput)
        else { return }
        session.addInput(deviceInput)
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.alwaysDiscardsLateVideoFrames = true
        if session.canAddOutput(dataOutput) {
            session.addOutput(dataOutput)
            dataOutput.setSampleBufferDelegate(delegate, queue: cameraQueue)
        } else { return }
        session.commitConfiguration()
        cameraSession = session
    }
}

extension CameraViewController: PredictorDelegate {
    func predictor(_ predictor: PoseEstimator, didLabelAction action: String, with confidence: Double) {
        print(action, confidence)
        if action == "pull up" && confidence > 0.95 && isPullUpDetected == false {
            isPullUpDetected = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isPullUpDetected = false
            }
            
            DispatchQueue.main.async {
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
        }
    }
}

extension AVCaptureDevice {
    func set(frameRate: Double) {
        guard let range = activeFormat.videoSupportedFrameRateRanges.first,
              range.minFrameRate...range.maxFrameRate ~= frameRate
        else {
            print("Requested FPS is not supported by the device's activeFormat !")
            return
        }
        
        do { try lockForConfiguration()
            activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: Int32(frameRate))
            activeVideoMaxFrameDuration = CMTimeMake(value: 1, timescale: Int32(frameRate))
            unlockForConfiguration()
        } catch {
            print("LockForConfiguration failed with error: \(error.localizedDescription)")
        }
    }
}
