import UIKit
import SwiftUI
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
    var cameraSession: AVCaptureSession?
    var audioSession: AVAudioPlayer?
    var delegate: AVCaptureVideoDataOutputSampleBufferDelegate?
    var poseEstimator: PoseEstimator?
    
    @Binding var selections: [String]
    var exerciseReps: ExerciseRepModel?
    
    @Binding var currentExercise: String {
        didSet {
            print("Current exercise: \(currentExercise)")
            playSound(currentExercise)
        }
    }
    
    @Binding var repCounter: Int {
        didSet {
            print("Rep counter: \(repCounter)")
        }
    }
    
    @Binding var repGoal: Int {
        didSet {
            print("Rep goal: \(repGoal)")
        }
    }
    
    @Binding var exerciseIndex: Int
    @Binding var shouldPopToRootView: Bool
    
    var exerciseDetected = false
    
    var terminated = false
    
    init(currentExercise: Binding<String>, repCounter: Binding<Int>, repGoal: Binding<Int>, exerciseIndex: Binding<Int>, shouldPopToRootView: Binding<Bool>, selections: Binding<[String]>) {
        self._currentExercise = currentExercise
        self._repCounter = repCounter
        self._repGoal = repGoal
        self._exerciseIndex = exerciseIndex
        self._shouldPopToRootView = shouldPopToRootView
        self._selections = selections
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        playSound(self.currentExercise)
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
    
    func playSound(_ exercise: String) {
        guard let url = Bundle.main.url(forResource: exercise, withExtension: "m4a") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            self.audioSession = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.m4a.rawValue)
            self.audioSession?.delegate = self

            guard let audioSession = self.audioSession else { return }

            audioSession.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension CameraViewController: PredictorDelegate {
    func predictor(_ predictor: PoseEstimator, didLabelAction action: String, with confidence: Double) {
        if action == currentExercise.lowercased() && confidence > 0.90 && exerciseDetected == false {
            exerciseDetected = true
            self.repCounter += 1
            
            DispatchQueue.main.async {
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
            
            if (repCounter == repGoal) {
                print("\(self.currentExercise) reps completed")
                if (self.exerciseIndex < (self.selections.count - 1)) {
                    self.exerciseIndex += 1
                    self.currentExercise = self.selections[self.exerciseIndex]
                    self.repGoal = self.exerciseReps!.exercisesReps[self.currentExercise]!
                    self.repCounter = 0
                    self.exerciseDetected = false
                } else {
                    print("Workout completed")
                    terminated = true
                    playSound("Terminated")
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.exerciseDetected = false
                }
            }
        }
    }
}

extension CameraViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (self.terminated && flag) {
            self.selections.removeAll()
            self.exerciseReps!.reset()
            self.shouldPopToRootView = false
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
