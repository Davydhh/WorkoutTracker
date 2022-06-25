//
//  ExerciseRepCell.swift
//  WorkoutTracker
//
//  Created by utente on 22/06/22.
//

import SwiftUI
import Combine

struct ExerciseRepCell: View {
    let exercise: String
    
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.blue)
                .frame(height: 100)
            HStack(alignment: .top){
                Text(exercise)
                    .foregroundColor(.white)
                    .font(.title)
//                TextField("Total number of people", value: $exercisesRep[exercise], formatter: NumberFormatter())
//                    .keyboardType(.numberPad)
            }
            .padding()
        }
        .padding()
    }
}

struct ExerciseRepCell_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRepCellPreviewWrapper()
    }
}

struct ExerciseRepCellPreviewWrapper: View {
    @State(initialValue: ["Push Up": 0]) var exercisesRep: [String: Int]
    
    var body: some View {
        ExerciseRepCell(exercise: "Push Up")
    }
}
