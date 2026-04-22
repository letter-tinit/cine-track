//
//  AlertView.swift
//  CineTrack
//
//  Created by TiniT on 22/4/26.
//

import SwiftUI

struct AlertButton: Identifiable {
    let id = UUID()
    let title: String
    let action: VoidClosure
}

struct AlertView: View {
    let alertType: AlertViewType
    var primaryAction: AlertButton?
    var secondaryAction: AlertButton?
    
    var body: some View {
        VStack {
            alertType.icon
                .resizable()
                .frame(width: 40, height: 40)
            
            Text(alertType.title)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(alertType.message)
                .font(.headline)
                .fontWeight(.medium)
                .lineLimit(7)
            
            HStack(spacing: 16) {
                if let secondaryAction {
                    Button {
                        secondaryAction.action()
                    } label: {
                        Text(secondaryAction.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .tint(.clear)
                    .buttonStyle(.glassProminent)
                }
                
                if let primaryAction {
                    Button {
                        primaryAction.action()
                    } label: {
                        Text(primaryAction.title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .tint(alertType.color)
                    .buttonStyle(.glassProminent)
                }
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding()
        .background(alertType.color)
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
        .opacity(0.7)
        .shadow(radius: 2)
        .padding(.horizontal, 30)
        .ignoresSafeArea()
    }
}
