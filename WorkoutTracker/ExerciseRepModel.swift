//
//  ExercisesModel.swift
//  WorkoutTracker
//
//  Created by utente on 25/06/22.
//

import Foundation

class ExerciseRepModel: ObservableObject {
    @Published var exercisesReps: [String: Int]
    
    init() {
        exercisesReps = [:]
    }
    
    func incrementReps(name: String) {
        exercisesReps[name] = exercisesReps[name]! + 1
    }
    
    func decrementReps(name: String) {
        exercisesReps[name] = exercisesReps[name]! - 1
    }
}
