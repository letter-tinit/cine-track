//
//  BackgroundView.swift
//  CineTrack
//
//  Created by TiniT on 6/4/26.
//

import SwiftUI

enum BackgroundGradientType {
    case purpleClassic
    case blueSunset
    case greenForest
    case custom(linear: [Color]? = nil, radial: [Color]? = nil)
}

struct BaseScreen<Content: View>: View {
    var backgroundType: BackgroundGradientType = .purpleClassic
    @Binding var isLoading: Bool
    let content: () -> Content
    
    init(
        backgroundType: BackgroundGradientType = .purpleClassic,
        isLoading: Binding<Bool> = .constant(false),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.backgroundType = backgroundType
        self._isLoading = isLoading
        self.content = content
    }
    
    private var linearColors: [Color] {
        switch backgroundType {
        case .purpleClassic:
            return [Color(red: 70/255, green: 50/255, blue: 150/255),
                    Color(red: 15/255, green: 10/255, blue: 50/255)]
        case .blueSunset:
            return [Color.blue, Color.orange]
        case .greenForest:
            return [Color.green.opacity(0.8), Color.black]
        case .custom(let linear, _):
            return linear ?? [Color.gray, Color.black]
        }
    }
    
    private var radialColors: [Color] {
        switch backgroundType {
        case .purpleClassic:
            return [Color.purple.opacity(0.3), Color.clear]
        case .blueSunset:
            return [Color.yellow.opacity(0.3), Color.clear]
        case .greenForest:
            return [Color.green.opacity(0.3), Color.clear]
        case .custom(_, let radial):
            return radial ?? [Color.clear, Color.clear]
        }
    }
    
    var body: some View {
        ZStack {
            ZStack {
                LinearGradient(
                    colors: linearColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                RadialGradient(
                    colors: radialColors,
                    center: .top,
                    startRadius: 0,
                    endRadius: 400
                )
            }
            .ignoresSafeArea()
            
            content()
                .blur(radius: isLoading ? 5 : 0)
            
            LoadingEffectView()
                .opacity(isLoading ? 1 : 0)
        }
    }
}
