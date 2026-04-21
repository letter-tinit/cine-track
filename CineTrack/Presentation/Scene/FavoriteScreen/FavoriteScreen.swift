//
//  FavoriteScreen.swift
//  CineTrack
//
//  Created by TiniT on 21/4/26.
//

import SwiftUI
import SwiftData

struct FavoriteScreen: View {
    @Environment(MovieStore.self) private var movieStore
    
    var body: some View {
        List {
            ForEach(movieStore.favoritedMovies) { movie in
                Text(movie.title)
            }
        }
        .onAppear {
            movieStore.loadFavorites()
        }
    }
}

#Preview {
    FavoriteScreen()
//        .environment(AppContainer().makeMovieStore())
}
