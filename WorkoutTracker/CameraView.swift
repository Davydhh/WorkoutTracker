//
//  CameraView2.swift
//  WorkoutTracker
//
//  Created by utente on 29/06/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var poseEstimator = PoseEstimator()
        
        var body: some View {
            VStack {
                ZStack {
                    GeometryReader { geo in
                        CameraViewWrapper(poseEstimator: poseEstimator)
                        StickFigureView(poseEstimator: poseEstimator, size: geo.size)
                    }
                }.frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width * 1920 / 1080, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
}
