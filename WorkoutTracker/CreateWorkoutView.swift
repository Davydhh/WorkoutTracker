//
//  CreateWorkoutView.swift
//  WorkoutTracker
//
//  Created by utente on 22/06/22.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Binding var selections: [String]
    @Binding var rootIsActive: Bool
    @ObservedObject var exerciseReps: ExerciseRepModel
    
    var body: some View {
        VStack() {
            List {
                ForEach(selections, id: \.self) { exercise in
                    ExerciseRepCell(exercise: exercise, exerciseRepModel: exerciseReps)
                        .listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
            NavigationLink(destination: CameraView(shouldPopToRootView: self.$rootIsActive, exerciseReps: exerciseReps, selections: $selections), label: { Text("Confirm")
                    .bold()
                    .frame(width: 280, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .isDetailLink(false)
            .frame(alignment: .bottom)
            .padding()
        }
    }
}

struct CreateWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWorkoutPreviewWrapper()
    }
}

struct CreateWorkoutPreviewWrapper: View {
    @State(initialValue: ["Push Up", "Squat"]) var selections: [String]
    @State(initialValue: true) var isActive: Bool
    
    var body: some View {
        CreateWorkoutView(selections: $selections, rootIsActive: $isActive, exerciseReps: ExerciseRepModel())
    }
}
