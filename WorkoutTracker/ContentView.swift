//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by utente on 21/06/22.
//

import SwiftUI

struct ContentView: View {
    @State var selections: [String] = []
    @State var isActive: Bool = false
    @StateObject var exerciseReps = ExerciseRepModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose your workout exercises")
                    .navigationTitle("Exercises")
                ExerciseListView(selections: $selections, exerciseReps: exerciseReps)
                if (!selections.isEmpty) {
                    NavigationLink(destination: CreateWorkoutView(selections: $selections, rootIsActive: self.$isActive, exerciseReps: exerciseReps), isActive: self.$isActive, label: { Text("Confirm")
                            .bold()
                            .frame(width: 280, height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    .isDetailLink(false)
                    .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
