//
//  BackdropAsyncImage.swift
//  CineTrack
//
//  Created by TiniT on 17/4/26.
//

import SwiftUI

struct BackdropAsyncImage: View {
    let url: URL?
    let designHeight: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { phase in
            content(for: phase)
                .aspectRatio(AppConstants.Scale.designWidth/designHeight, contentMode: .fit)
                .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    private func content(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .redacted(reason: .placeholder)

        case .success(let image):
            image
                .resizable()
                .unredacted() // ensure no leftover redaction

        case .failure:
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)

        @unknown default:
            EmptyView()
        }
    }
}

#Preview {
//    BackdropAsyncImage()
}
