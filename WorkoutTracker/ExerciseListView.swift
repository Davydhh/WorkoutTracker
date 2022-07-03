//
//  ExerciseListView.swift
//  WorkoutTracker
//
//  Created by utente on 22/06/22.
//

import SwiftUI

var exercises = Model.init().exercises

struct ExerciseListView: View {
    @Binding var selections: [String]
    @State private var isEditable = false
    @ObservedObject var exerciseReps: ExerciseRepModel
    
    var body: some View {
        List {
            ForEach(exercises, id: \.self) { exercise in
                ExerciseRow(name: exercise, isSelected: self.selections.contains(exercise)) {
                    if self.selections.contains(exercise) {
                        self.selections.removeAll(where: { $0 == exercise })
                    } else {
                        self.selections.append(exercise)
                        exerciseReps.exercisesReps[exercise] = 1
                    }
                }
            }
            .onMove(perform: move)
            .onLongPressGesture {
                withAnimation {
                    self.isEditable = true
                }
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        exercises.move(fromOffsets: source, toOffset: destination)
        withAnimation {
            isEditable = false
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
}

struct PreviewWrapper: View {
    @State(initialValue: [String]()) var selections: [String]
    
    var body: some View {
        ExerciseListView(selections: $selections, exerciseReps: ExerciseRepModel())
    }
}
