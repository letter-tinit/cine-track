//
//  ScaledAsyncImage.swift.swift
//  CineTrack
//
//  Created by TiniT on 6/4/26.
//

import SwiftUI
import Lottie

struct ScaledAsyncImage: View {
    let url: URL?
    let designWidth: CGFloat
    let designHeight: CGFloat
    var cornerRadius: CGFloat = 0
    
    @State private var delayedURL: URL? = nil
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                LottieView(animation: .named("video_cam"))
                    .playing()
                    .looping()
                    .animationSpeed(1.5)
                    .aspectRatio(designWidth/designHeight, contentMode: .fit)
                    .frame(width: designWidth.scaledWidth)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(designWidth/designHeight, contentMode: .fit)
                    .frame(width: designWidth.scaledWidth)
                    .clipShape(
                        RoundedRectangle(cornerRadius: cornerRadius)
                    )
            case .failure(_):
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: designWidth.scaledWidth)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}
