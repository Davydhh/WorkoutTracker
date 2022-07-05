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
    @Binding var index: Int
    @Binding var shouldPopToRootView: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let cvc = CameraViewController(currentExercise: $currentExercise, repCounter: $repCounter, repGoal: $repGoal, exerciseIndex: $index, shouldPopToRootView: $shouldPopToRootView, selections: $selections)
        cvc.delegate = poseEstimator
        cvc.poseEstimator = poseEstimator
        cvc.exerciseReps = exerciseReps
        return cvc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
