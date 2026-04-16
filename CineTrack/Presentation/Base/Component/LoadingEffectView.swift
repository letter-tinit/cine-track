//
//  LoadingEffectView.swift
//  CineTrack
//
//  Created by TiniT on 15/4/26.
//

import SwiftUI

struct LoadingEffectView: View {
    @State private var isAnimating = false
    
    var body: some View {
        Color
            .cyan
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .opacity(0.6)
            .shadow(radius: 3)
            .overlay {
                LoadingAnimationView()
                    .frame(width: 160, height: 160)
            }
            .frame(width: 120, height: 100)
            .ignoresSafeArea()
    }
}

#Preview {
    LoadingEffectView()
}
