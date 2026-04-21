//
//  Persistence.swift
//  CineTrack
//
//  Created by TiniT on 21/4/26.
//

import SwiftData

enum Persistence {
    static func makeContainer(inMemory: Bool = false) -> ModelContainer {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            return try ModelContainer(
                for: FavoriteMovieEntity.self,
                configurations: config
            )
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}
