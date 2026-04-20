//
//  ScaledAsyncThumnailImage.swift.swift
//  CineTrack
//
//  Created by TiniT on 6/4/26.
//

import SwiftUI

struct ScaledAsyncThumnailImage: View {
    let url: URL?
    let designWidth: CGFloat
    let designHeight: CGFloat
    var cornerRadius: CGFloat = 0
    
    var body: some View {
        AsyncImage(url: url) { phase in
            content(for: phase)
                .aspectRatio(designWidth/designHeight, contentMode: .fit)
                .frame(width: designWidth.scaledWidth)
                .clipShape(
                    RoundedRectangle(cornerRadius: cornerRadius)
                )
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
                .unredacted()

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
