//
//  View+Exntension.swift
//  CineTrack
//
//  Created by TiniT on 15/4/26.
//

import SwiftUI

extension View {
    func screenNameStyle() -> some View {
        self
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .opacity(0.8)
            .shadow(color: .cyan, radius: 2)
    }
    
    func headingStyle() -> some View {
        self
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
    }
    
    func errorAlert(_ errorMessage: Binding<String?>) -> some View {
        self.modifier(ErrorAlertModifier(errorMessage: errorMessage))
    }
    
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
