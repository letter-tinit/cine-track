//
//  ContentView.swift
//  CineTrack
//
//  Created by TiniT on 31/3/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: MovieListViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                MovieRowView(movie: .mock)
            }
            .navigationTitle("Trending")
        }
        .task {
            await viewModel.loadMovies()
        }
    }
}

#Preview {
    let container = AppContainer()
    ContentView(viewModel: container.makeMovieListViewModel())
}
