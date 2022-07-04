import Foundation
import SwiftUI
import AVFoundation
import Vision

struct CameraViewWrapper: UIViewControllerRepresentable {
    @ObservedObject var exerciseReps: ExerciseRepModel
    @Binding var selections: [String]
    @Binding var currentExercise: String
    var poseEstimator: PoseEstimator
    @Binding var repCounter: Int
    @Binding var repGoal: Int
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let cvc = CameraViewController(currentExercise: $currentExercise, repCounter: $repCounter, repGoal: $repGoal)
        cvc.delegate = poseEstimator
        cvc.poseEstimator = poseEstimator
        cvc.exerciseReps = exerciseReps
        cvc.selections = selections
        return cvc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
