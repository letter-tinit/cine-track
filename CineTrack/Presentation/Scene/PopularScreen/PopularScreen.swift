//
//  PopularScreen.swift
//  CineTrack
//
//  Created by TiniT on 9/4/26.
//

import SwiftUI

struct PopularScreen: View {
    @Bindable var viewModel: MovieStore
    
    let columns: [GridItem] = [
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(viewModel.popularMovies) { movie in
                    MovieView(movie: movie)
                }
            }
            .padding()
        }
    }
}

#Preview {
    PopularScreen(viewModel: AppContainer().makeMovieStore())
}
