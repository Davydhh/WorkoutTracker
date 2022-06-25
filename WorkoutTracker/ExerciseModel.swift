//
//  ExerciseModel.swift
//  WorkoutTracker
//
//  Created by utente on 25/06/22.
//

import Foundation

struct Model {
    var exercises = [String]()
    
    init() {
        exercises.append("Push Up")
        exercises.append("Pull Up")
        exercises.append("Squat")
    }
}
