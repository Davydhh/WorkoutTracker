//
//  CameraView2.swift
//  WorkoutTracker
//
//  Created by utente on 29/06/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var poseEstimator = PoseEstimator()
    @Binding var shouldPopToRootView: Bool
    
    @State var showStick = true
    
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geo in
                    CameraViewWrapper(poseEstimator: poseEstimator)
                    Button(action: { showStick = !showStick }) {
                        if showStick {
                            Image(systemName: "person.fill")
                                .font(.system(size: 30.0))
                        } else {
                            Image(systemName: "person")
                                .font(.system(size: 30.0))
                        }
                    }.padding()
                    if showStick {
                        StickFigureView(poseEstimator: poseEstimator, size: geo.size)
                    }
                }
            }
            Button(action: { self.shouldPopToRootView = false }) {
                Text("Finish")
                    .bold()
                    .frame(width: 280, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }.padding()
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraViewWrapperPreview()
    }
}


struct CameraViewWrapperPreview: View {
    @State(initialValue: true) var isActive
    
    var body: some View {
        CameraView(shouldPopToRootView: $isActive)
    }
}
