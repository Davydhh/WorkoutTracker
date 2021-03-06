//
//  CameraView2.swift
//  WorkoutTracker
//
//  Created by utente on 29/06/22.
//

import SwiftUI
import AVFoundation

var audioSession: AVAudioPlayer?

struct CameraView: View {
    @StateObject var poseEstimator = PoseEstimator()
    @Binding var shouldPopToRootView: Bool
    @ObservedObject var exerciseReps: ExerciseRepModel
    @Binding var selections: [String]
    @State var showStick = true
    @State var currentExercise: String
    @State var repGoal: Int
    @State var repCounter: Int = 0
    @State var index = 0
    @State var startTime =  Date()
    @State var exerciseSummary = [String: ExerciseSummaryModel]()
    @State var hasFinished = false
    
    init(shouldPopToRootView: Binding<Bool>, exerciseReps: ExerciseRepModel, selections: Binding<[String]>) {
        self._shouldPopToRootView = shouldPopToRootView
        self.exerciseReps = exerciseReps
        self._selections = selections
        let currentExercise = selections.first?.wrappedValue ?? ""
        self._currentExercise = State(initialValue: currentExercise)
        let repGoal = exerciseReps.exercisesReps[currentExercise] ?? 0
        self._repGoal = State(initialValue: repGoal)
    }
    
    var body: some View {
        if (self.shouldPopToRootView) {
            VStack {
                Spacer()
                if (!selections.isEmpty) {
                    Text(currentExercise)
                        .onAppear {
                            self.currentExercise = selections.first!
                        }
                        .font(
                            .largeTitle
                                .weight(.bold)
                        )
                        .foregroundColor(.blue)
                }
                ZStack {
                    GeometryReader { geo in
                        CameraViewWrapper(exerciseReps: exerciseReps, selections: $selections, currentExercise: $currentExercise, poseEstimator: poseEstimator, repCounter: $repCounter, repGoal: $repGoal, index: $index, shouldPopToRootView: $shouldPopToRootView, startTime: $startTime, exerciseSummary: $exerciseSummary
                        )
                        HStack {
                            Button(action: { showStick = !showStick }) {
                                if showStick {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 30.0))
                                } else {
                                    Image(systemName: "person")
                                        .font(.system(size: 30.0))
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(repCounter)/\(repGoal)")
                                .padding()
                                .font(.system(size: 30, weight: .heavy, design: .default))
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        if showStick {
                            StickFigureView(poseEstimator: poseEstimator, size: geo.size)
                        }
                    }
                }
                if (index == selections.count - 1) {
                    VStack {
                        NavigationLink(destination: SummaryView(shouldPopToRootView: $shouldPopToRootView, selections: $selections, exerciseSummary: $exerciseSummary), isActive: $hasFinished) {
                            EmptyView()
                        }
                        .isDetailLink(false)
                        Button(action: {
                            exerciseSummary[currentExercise] = ExerciseSummaryModel(reps: repGoal, time: String(format: "%.2f", (Date().timeIntervalSince( self.startTime))))
                            exerciseReps.reset()
                            self.hasFinished = true
                        }) {
                            Text("Finish")
                                .bold()
                                .frame(width: 280, height: 50)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }.padding()
                    }
                } else {
                    Button(action: {
                        exerciseSummary[currentExercise] = ExerciseSummaryModel(reps: repGoal, time: String(format: "%.2f", (Date().timeIntervalSince( self.startTime))))
                        startTime = Date()
                        index += 1
                        currentExercise = selections[index]
                        repGoal = exerciseReps.exercisesReps[currentExercise]!
                        repCounter = 0
                        playSound(currentExercise)
                    }) {
                        Text("Next")
                            .bold()
                            .frame(width: 280, height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                        
                    }.padding()
                }
            }
        } else {
            EmptyView()
        }
    }
    
    func playSound(_ exercise: String) {
        guard let url = Bundle.main.url(forResource: exercise, withExtension: "m4a") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioSession = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.m4a.rawValue)
            
            guard let audioSession = audioSession else { return }
            
            audioSession.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraViewWrapperPreview()
    }
}


struct CameraViewWrapperPreview: View {
    @State(initialValue: true) var isActive
    @State(initialValue: ["Pull Up"]) var selections
    @StateObject var exerciseReps = ExerciseRepModel()
    
    var body: some View {
        CameraView(shouldPopToRootView: $isActive, exerciseReps: exerciseReps, selections: $selections)
    }
}
