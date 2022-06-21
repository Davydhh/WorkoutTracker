//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by utente on 21/06/22.
//

import SwiftUI

let exercises = Model().exercises

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose your workout exercises")
                    .navigationTitle("Exercises")
                List(exercises) {
                    exercise in ExerciseRow(exercise: exercise)
                }
                NavigationLink(destination: Text("Destination"), label: { Text("Confirm")
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
