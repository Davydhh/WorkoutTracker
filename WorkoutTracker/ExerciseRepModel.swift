//
//  ExercisesModel.swift
//  WorkoutTracker
//
//  Created by utente on 25/06/22.
//

import Foundation

class ExerciseRepModel: ObservableObject {
    @Published var exercisesReps: [String: Int] {
        didSet {
            for (key, value) in exercisesReps {
                var s = String(value)
                
                if s.count > 3 {
                    s = String(s.prefix(3))
                    exercisesReps[key] = Int(s) ?? 1
                }
            }
        }
    }
    
    init() {
        exercisesReps = [:]
        
        for exercise in Model().exercises {
            exercisesReps[exercise] = 0
        }
    }
    
    func reset() {
        for exercise in exercisesReps.keys {
            exercisesReps[exercise] = 0
        }
    }
    
    func incrementReps(name: String) {
        exercisesReps[name] = exercisesReps[name]! + 1
    }
    
    func decrementReps(name: String) {
        exercisesReps[name] = exercisesReps[name]! - 1
    }
}
