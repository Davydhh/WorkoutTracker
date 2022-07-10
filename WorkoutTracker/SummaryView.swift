//
//  SummaryView.swift
//  WorkoutTracker
//
//  Created by utente on 10/07/22.
//

import SwiftUI

struct SummaryView: View {
    @Binding var shouldPopToRootView: Bool
    @Binding var selections: [String]
    @Binding var exerciseSummary: [String: ExerciseSummaryModel]
    
    var body: some View {
        VStack {
            List {
                ForEach(selections, id: \.self) { exercise in
                    ExerciseSummaryCell(exercise: exercise, exerciseSummaryModel: exerciseSummary[exercise]!)
                        .listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
            Text("Total reps: \(exerciseSummary.values.map {$0.reps}.reduce(0, +))")
            Text("Total time: \(String(format: "%.2f", exerciseSummary.values.map {Double($0.time)!}.reduce(0, +)))")
            Button(action: {
                selections.removeAll()
                self.shouldPopToRootView = false
            }) {
                Text("Start")
                    .bold()
                    .frame(width: 280, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }.padding()
        }
        .navigationBarHidden(true)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryViewPreviewWrapper()
    }
}

struct SummaryViewPreviewWrapper: View {
    @State(initialValue: true) var isActive: Bool
    @State(initialValue: ["Pull Up"]) var selections: [String]
    @State(initialValue: ["Pull Up": ExerciseSummaryModel(reps: 0, time: "0.00")]) var exerciseSummary
    
    var body: some View {
        SummaryView(shouldPopToRootView: $isActive, selections: $selections, exerciseSummary: $exerciseSummary)
    }
}
