//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by utente on 21/06/22.
//

import SwiftUI

struct ContentView: View {
    @State var selections: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose your workout exercises")
                    .navigationTitle("Exercises")
                ExerciseListView(selections: $selections)
                NavigationLink(destination: CreateWorkoutView(selections: $selections), label: { Text("Confirm")
                        .bold()
                        .frame(width: 280, height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
