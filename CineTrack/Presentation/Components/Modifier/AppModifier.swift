//
//  TitleStyle.swift
//  CineTrack
//
//  Created by TiniT on 6/4/26.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    var font: Font = .title3
    var weight: Font.Weight = .bold
    var color: Color = .white
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(weight)
            .foregroundColor(color)
    }
}

extension View {
    func screenNameStyle() -> some View {
        self
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.white)
    }
    
    func headingStyle() -> some View {
        self
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.white)
    }
}
