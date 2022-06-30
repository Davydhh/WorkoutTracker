//
//  CameraView2.swift
//  WorkoutTracker
//
//  Created by utente on 29/06/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var poseEstimator = PoseEstimator()
    
    @State var showStick = true
    
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geo in
                    CameraViewWrapper(poseEstimator: poseEstimator)
                    Button(action: { showStick = !showStick }) {
                        Text("Show stick")
                    }.padding()
                    if showStick {
                        StickFigureView(poseEstimator: poseEstimator, size: geo.size)
                    }
                }
            }
            Button(action: {}) {
                Text("Finish")
            }.padding()
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
