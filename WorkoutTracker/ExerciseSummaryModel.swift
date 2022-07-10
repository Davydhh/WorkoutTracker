//
//  ExerciseSummaryModel.swift
//  WorkoutTracker
//
//  Created by utente on 10/07/22.
//

import Foundation

struct ExerciseSummaryModel {
    var reps: Int
    var time: String
    
    init(reps: Int, time: String) {
        self.reps = reps
        self.time = time
    }
}
