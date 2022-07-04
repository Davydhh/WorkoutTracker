import Foundation
import SwiftUI
import AVFoundation
import Vision

struct CameraViewWrapper: UIViewControllerRepresentable {
    @ObservedObject var exerciseReps: ExerciseRepModel
    @Binding var selections: [String]
    @Binding var currentExercise: String
    var poseEstimator: PoseEstimator
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let cvc = CameraViewController()
        cvc.delegate = poseEstimator
        cvc.poseEstimator = poseEstimator
        cvc.exerciseReps = exerciseReps
        cvc.selections = selections
        cvc.currentExercise = currentExercise
        return cvc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
