//
//  CreateWorkoutView.swift
//  WorkoutTracker
//
//  Created by utente on 22/06/22.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Binding var selections: [String]
    @StateObject var exerciseReps = ExerciseRepModel()
    
    var body: some View {
        VStack() {
            ForEach(selections, id: \.self) { exercise in
                ExerciseRepCell(exercise: exercise, exerciseRepModel: exerciseReps)
            }
            NavigationLink(destination: CameraController(), label: { Text("Confirm")
                    .bold()
                    .frame(width: 280, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }).frame(maxHeight: .infinity, alignment: .bottom)
            Spacer()
        }
    }
}


struct CameraController: UIViewControllerRepresentable {
    typealias UIViewControllerType = CameraViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraController>) -> CameraController.UIViewControllerType {
        let sb = UIStoryboard(name: "CameraController", bundle: nil)
        let viewController = sb.instantiateViewController(identifier: "Camera") as! CameraViewController
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: CameraController.UIViewControllerType, context: UIViewControllerRepresentableContext<CameraController>) {
    }
}

struct CreateWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWorkoutPreviewWrapper()
    }
}

struct CreateWorkoutPreviewWrapper: View {
    @State(initialValue: ["Push Up", "Squat"]) var selections: [String]
    
    var body: some View {
        CreateWorkoutView(selections: $selections, exerciseReps: ExerciseRepModel())
    }
}
