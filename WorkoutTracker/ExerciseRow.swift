//
//  ExerciseRow.swift
//  WorkoutTracker
//
//  Created by utente on 21/06/22.
//

import SwiftUI

struct ExerciseRow: View {
    var exercise: Exercise
    var body: some View {
        Text(exercise.name)
    }
}

struct ExerciseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRow(exercise: Model().exercises[0])
    }
}
