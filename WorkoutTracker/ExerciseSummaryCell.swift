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
                .frame(height: 100)
            VStack {
                Text(exercise)
                    .foregroundColor(.white)
                    .font(.title)
                HStack {
                    Spacer()
                    Spacer()
                    VStack(spacing: 8) {
                        Text("Reps")
                            .foregroundColor(.white)
                            .font(.headline)
                        Text(String(exerciseSummaryModel.reps))
                            .foregroundColor(.white)
                            .font(.callout)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(spacing: 8) {
                        Text("Time")
                            .foregroundColor(.white)
                            .font(.headline)
                        Text("\(exerciseSummaryModel.time)s")
                            .foregroundColor(.white)
                            .font(.callout)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    Spacer()
                    Spacer()
                }
            }
        }.padding()
    }
}

struct ExerciseSummaryCell_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSummaryCell(exercise: "Pull Up", exerciseSummaryModel: ExerciseSummaryModel(reps: 0, time: "0.00"))
    }
}
