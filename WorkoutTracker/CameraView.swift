//
//  CameraView2.swift
//  WorkoutTracker
//
//  Created by utente on 29/06/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var poseEstimator = PoseEstimator()
    @Binding var shouldPopToRootView: Bool
    @ObservedObject var exerciseReps: ExerciseRepModel
    @Binding var selections: [String]
    @State var showStick = true
    @State var currentExercise: String
    
    init(shouldPopToRootView: Binding<Bool>, exerciseReps: ExerciseRepModel, selections: Binding<[String]>) {
        self._shouldPopToRootView = shouldPopToRootView
        self.exerciseReps = exerciseReps
        self._selections = selections
        let currentEx = selections.first?.wrappedValue ?? ""
        self._currentExercise = State(initialValue: currentEx)
    }
    
    var body: some View {
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
                    CameraViewWrapper(exerciseReps: exerciseReps, selections: $selections, currentExercise: $currentExercise, poseEstimator: poseEstimator)
                    Button(action: { showStick = !showStick }) {
                        if showStick {
                            Image(systemName: "person.fill")
                                .font(.system(size: 30.0))
                        } else {
                            Image(systemName: "person")
                                .font(.system(size: 30.0))
                        }
                    }.padding()
                    if showStick {
                        StickFigureView(poseEstimator: poseEstimator, size: geo.size)
                    }
                }
            }
            Button(action: {
                self.shouldPopToRootView = false
                selections.removeAll()
            }) {
                Text("Finish")
                    .bold()
                    .frame(width: 280, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }.padding()
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
    
    var body: some View {
        CameraView(shouldPopToRootView: $isActive, exerciseReps: ExerciseRepModel(), selections: $selections)
    }
}
