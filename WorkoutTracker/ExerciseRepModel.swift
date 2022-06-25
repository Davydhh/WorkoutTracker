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
    
    func setExerciseRep(name: String, n: Int) {
        exercisesReps[name] = n
    }
}
