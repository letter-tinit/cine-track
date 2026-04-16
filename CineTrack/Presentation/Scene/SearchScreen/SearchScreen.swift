//
//  SearchScreen.swift
//  CineTrack
//
//  Created by TiniT on 15/4/26.
//

import SwiftUI

struct SearchScreen: View {
    @Environment(SearchRouter.self) private var router
    
    var body: some View {
        BaseScreen(isLoading: .constant(true)) {
            Button {
                router.push(.movieDetail)
            } label: {
                Text(verbatim: "GOTO EMPTY")
            }
            .navigationDestination(for: SearchRoute.self) { route in
                switch route {
                case .movieDetail:
                    DumbView()
                }
            }
        }
    }
}

#Preview {
    SearchScreen()
}
