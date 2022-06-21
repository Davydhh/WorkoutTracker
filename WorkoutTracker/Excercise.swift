//
//  Excercise.swift
//  WorkoutTracker
//
//  Created by utente on 21/06/22.
//

import Foundation

struct Exercise: Identifiable {
    var id = UUID()
    let name: String
}


struct Model {
    var exercises = [Exercise]()
    init() {
        exercises.append(Exercise(name: "Push Up"))
        exercises.append(Exercise(name: "Pull Up"))
        exercises.append(Exercise(name: "Squat"))
    }
}
