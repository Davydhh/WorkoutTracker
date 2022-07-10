//
//  ExerciseSummaryCell.swift
//  WorkoutTracker
//
//  Created by utente on 10/07/22.
//

import SwiftUI

struct ExerciseSummaryCell: View {
    let exercise: String
    let exerciseSummaryModel: ExerciseSummaryModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.blue)
                .frame(height: 80)
            Text("\(exercise): \(exerciseSummaryModel.reps), \(exerciseSummaryModel.time)")
        }.padding()
    }
}

struct ExerciseSummaryCell_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSummaryCell(exercise: "Pull Up", exerciseSummaryModel: ExerciseSummaryModel(reps: 0, time: "0.00"))
    }
}
