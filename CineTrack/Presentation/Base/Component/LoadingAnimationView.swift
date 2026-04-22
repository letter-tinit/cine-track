//
//  LoadingAnimationView.swift
//  CineTrack
//
//  Created by TiniT on 15/4/26.
//

import SwiftUI
import Lottie

struct LoadingAnimationView: View {
    var body: some View {
        LottieView(animation: .named("video_cam"))
            .playing()
            .looping()
            .animationSpeed(1.5)
        
    }
}

#Preview {
    LoadingAnimationView()
}
