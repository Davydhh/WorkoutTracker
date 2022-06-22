//
//  ExerciseListView.swift
//  WorkoutTracker
//
//  Created by utente on 22/06/22.
//

import SwiftUI

struct ExerciseListView: View {
    @State var exercises: [String] = ["Push Up", "Pull Up", "Squat"]
    @State var selections: [String] = []
    
    var body: some View {
        List {
            ForEach(self.exercises, id: \.self) { exercise in
                ExerciseRow(name: exercise, isSelected: self.selections.contains(exercise)) {
                    if self.selections.contains(exercise) {
                        self.selections.removeAll(where: { $0 == exercise })
                    }
                    else {
                        self.selections.append(exercise)
                    }
                }
            }
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
    }
}
