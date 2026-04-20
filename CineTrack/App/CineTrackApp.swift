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
    @State private var store = AppContainer().makeMovieStore()
    
    var body: some Scene {
        WindowGroup {
            MainTabScreen()
                .environment(store)
        }
    }
}
