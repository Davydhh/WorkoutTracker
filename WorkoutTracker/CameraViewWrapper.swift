import Foundation
import SwiftUI
import AVFoundation
import Vision
import Combine

struct CameraViewWrapper: UIViewControllerRepresentable {
    @ObservedObject var exerciseReps: ExerciseRepModel
    @Binding var selections: [String]
    @Binding var currentExercise: String
    var poseEstimator: PoseEstimator
    @Binding var repCounter: Int
    @Binding var repGoal: Int
    @Binding var index: Int
    @Binding var shouldPopToRootView: Bool
    @Binding var startTime: Date
    @Binding var exerciseSummary: [String: ExerciseSummaryModel]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let cvc = CameraViewController(currentExercise: $currentExercise, repCounter: $repCounter, repGoal: $repGoal, exerciseIndex: $index, shouldPopToRootView: $shouldPopToRootView, selections: $selections, startTime: $startTime, exerciseSummary: $exerciseSummary)
        cvc.delegate = poseEstimator
        cvc.poseEstimator = poseEstimator
        cvc.exerciseReps = exerciseReps
        return cvc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
