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
    @State var showingAlert = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            ZStack() {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.blue)
                    .frame(height: 80)
                HStack() {
                    Text(exercise)
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if (!isFocused) {
                        Button(action: {
                            guard let reps = exerciseRepModel.exercisesReps[exercise] else { return }
                            
                            guard reps <= 1 else {
                                showingAlert = false
                                exerciseRepModel.decrementReps(name: exercise)
                                return
                            }
                            
                            showingAlert = true
                        }) {
                            Text("-")
                                .font(.title)
                        }
                        .alert("Reps can't be less equal to zero", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { }
                        }
                        .buttonStyle(RepsButton())
                    }
                    TextField("reps", value: $exerciseRepModel.exercisesReps[exercise], formatter: NumberFormatter())
                        .focused($isFocused)
                        .keyboardType(.numberPad)
                        .onReceive(Just(String(exerciseRepModel.exercisesReps[exercise] ?? -1))) { newValue in
                                                        
                            guard newValue == "-1" else {
                                if newValue.count > 3 {
                                    exerciseRepModel.exercisesReps[exercise] = Int(String(newValue.prefix(3)))
                                }
                                return
                            }
                            
                            exerciseRepModel.exercisesReps[exercise] = 1
                        }
                        .frame(maxWidth: 100)
                        .foregroundColor(.white)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: true, vertical: true)
                    if (!isFocused) {
                        Button(action: {
                            guard let reps = exerciseRepModel.exercisesReps[exercise] else { return }
                            
                            guard reps >= 999 else {
                                showingAlert = false
                                exerciseRepModel.incrementReps(name: exercise)
                                return
                            }
                            
                            showingAlert = true
                        }) {
                            Text("+")
                                .font(.title)
                        }
                        .alert("Reps can't be less equal to zero", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { }
                        }
                        .buttonStyle(RepsButton())
                    }
                }
                .padding()
            }
            if (isFocused) {
                Button("Done") {
                    isFocused = false
                    
                    let reps = exerciseRepModel.exercisesReps[exercise] ?? 1
                    
                    guard reps > 999 else {
                        exerciseRepModel.exercisesReps[exercise] = reps
                        return
                    }
                    
                    exerciseRepModel.exercisesReps[exercise] = 999
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
    }
}

struct RepsButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 2 : 1)
            .frame(width: 40, height: 40, alignment: .center)
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
