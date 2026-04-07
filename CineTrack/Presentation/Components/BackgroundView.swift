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

struct BackgroundView<Content: View>: View {
    let type: BackgroundGradientType
    let content: () -> Content
    
    init(type: BackgroundGradientType = .purpleClassic,
         @ViewBuilder content: @escaping () -> Content = { EmptyView() }) {
        self.type = type
        self.content = content
    }
    
    private var linearColors: [Color] {
        switch type {
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
        switch type {
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
        }
    }
}

#Preview {
    BackgroundView()
}
