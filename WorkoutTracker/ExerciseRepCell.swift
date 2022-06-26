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
    @ObservedObject var exerciseRepModel: ExerciseRepModel
    @State private var showingAlert = false
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.blue)
                .frame(height: 80)
            HStack() {
                Text(exercise)
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    guard exerciseRepModel.exercisesReps[exercise]! == 0 else {
                        showingAlert = false
                        exerciseRepModel.decrementReps(name: exercise)
                        return
                    }
                    
                    showingAlert = true
                }) {
                    Text("-")
                        .font(.title)
                }
                .alert("Reps can't be less than zero", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .buttonStyle(RepsButton())
                TextField("Reps", value: $exerciseRepModel.exercisesReps[exercise], formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .foregroundColor(.white)
                    .font(.title)
                Button(action: {
                    exerciseRepModel.incrementReps(name: exercise)
                }) {
                    Text("+")
                        .font(.title)
                }
                .buttonStyle(RepsButton())
            }
            .padding()
        }
        .padding()
    }
}

struct RepsButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 50, height: 50)
            .cornerRadius(10)
            .foregroundColor(.white)
            .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(Color.white, lineWidth: 2))
    }
}

struct ExerciseRepCell_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRepCell(exercise: "Push Up", exerciseRepModel: ExerciseRepModel())
    }
}
