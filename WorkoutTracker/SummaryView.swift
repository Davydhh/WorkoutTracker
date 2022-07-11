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
            HStack {
                VStack(spacing: 8) {
                    Text("Total reps")
                        .font(.largeTitle)
                    Text(String(exerciseSummary.values.map {$0.reps}.reduce(0, +)))
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .font(
                        .system(size: 34, weight: .semibold)
                    )
                VStack(spacing: 8) {
                    Text("Total time")
                        .font(.largeTitle)
                    Text(secondsToHoursMinutesSeconds(exerciseSummary.values.map { Double($0.time)!}.reduce(0, +)))
                        .font(
                            .system(size: 34, weight: .semibold)
                        )
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }.padding()
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
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Summary")
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Double) -> String {
        let s = Int(seconds)
        return "\(s / 3600)h \(s % 3600 / 60)m \(s % 3600 % 60)s"
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
