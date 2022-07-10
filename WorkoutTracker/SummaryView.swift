//
//  SummaryView.swift
//  WorkoutTracker
//
//  Created by utente on 10/07/22.
//

import SwiftUI

struct SummaryView: View {
    @Binding var shouldPopToRootView: Bool
    @ObservedObject var exerciseReps: ExerciseRepModel
    @Binding var selections: [String]
    
    var body: some View {
        ForEach(selections, id: \.self) { exercise in
            Text("\(exercise): \(exerciseReps.exercisesReps[exercise]!)")
        }
        Button(action: {
            selections.removeAll()
            exerciseReps.reset()
            self.shouldPopToRootView = false
        }) {
            Text("Start")
                .bold()
                .frame(width: 280, height: 50)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            
        }.padding()
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryViewPreviewWrapper()
    }
}

struct SummaryViewPreviewWrapper: View {
    @State(initialValue: true) var isActive: Bool
    @State(initialValue: ["Push Up"]) var selections: [String]
    
    var body: some View {
        SummaryView(shouldPopToRootView: $isActive, exerciseReps: ExerciseRepModel(), selections: $selections)
    }
}
