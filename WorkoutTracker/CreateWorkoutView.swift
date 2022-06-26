//
//  CreateWorkoutView.swift
//  WorkoutTracker
//
//  Created by utente on 22/06/22.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Binding var selections: [String]
    @StateObject var exerciseReps = ExerciseRepModel()
    
    var body: some View {
        ForEach(selections, id: \.self) { exercise in
            ExerciseRepCell(exercise: exercise, exerciseRepModel: exerciseReps)
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
    
    var body: some View {
        CreateWorkoutView(selections: $selections, exerciseReps: ExerciseRepModel())
    }
}
