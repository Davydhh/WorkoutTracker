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
        
        for exercise in Model().exercises {
            exercisesReps[exercise] = 0
        }
    }
    
    func setExerciseRep(name: String, n: Int) {
        exercisesReps[name] = n
    }
}
