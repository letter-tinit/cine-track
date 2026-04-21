//
//  CineTrackApp.swift
//  CineTrack
//
//  Created by TiniT on 31/3/26.
//

import SwiftUI
import SwiftData

@main
struct CineTrackApp: App {
    private let appContainer = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            MainTabScreen()
                .environment(appContainer.makeMovieStore())
        }
    }
}
