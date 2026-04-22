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

struct AlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    let alertType: AlertViewType
    let primaryAction: AlertButton?
    let secondaryAction: AlertButton?
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isPresented ? 5 : 0)
                .disabled(isPresented)
            if isPresented {
                Color.gray.opacity(0.001)
                    .onTapGesture {
                        isPresented = false
                    }
                    .ignoresSafeArea()

                
                AlertView(
                    alertType: alertType,
                    primaryAction: primaryAction,
                    secondaryAction: secondaryAction
                )
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(duration: 0.3), value: isPresented)
    }
}
