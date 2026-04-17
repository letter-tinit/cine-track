//
//  TitleStyle.swift
//  CineTrack
//
//  Created by TiniT on 6/4/26.
//

import SwiftUI

struct NavigationToolbarModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    let title: String?
    let hasBack: Bool
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                if let title {
                    ToolbarItem(placement: .title) {
                        Text(title)
                            .screenNameStyle()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

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

struct ErrorAlertModifier: ViewModifier {
    @Binding var errorMessage: String?
    
    func body(content: Content) -> some View {
        content.alert(
            "Error",
            isPresented: Binding(
                get: { errorMessage != nil },
                set: { if !$0 { errorMessage = nil } }
            )
        ) {
            Button("OK", role: .cancel) {
                errorMessage = nil
            }
        } message: {
            Text(errorMessage ?? "")
        }
    }
}
