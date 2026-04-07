//
//  ContentView.swift
//  CineTrack
//
//  Created by TiniT on 31/3/26.
//

import SwiftUI
import Lottie

struct ContentView: View {
    @State private var path = NavigationPath()
    @StateObject var viewModel: MovieListViewModel
    
    var body: some View {
        NavigationStack(path: $path) {
            // MARK: - Background
            BackgroundView(type: .blueSunset) {
                // MARK: - MainStack
                VStack {
                    // MARK: - TRENDING MOVIE
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Featured Movie")
                            .headingStyle()
                        
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 20) {
                                ForEach(viewModel.movies) { movie in
                                    MovieItemView(
                                        movie: movie,
                                        itemType: .largeItem,
                                        cornerRadius: 16
                                    )
                                }
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .scrollIndicators(.hidden)
                        .background(.cyan)
                    }
                    .padding(.horizontal, 16)
                    
                    // MARK: - Popular TV Show
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Popular TV Show")
                            .headingStyle()
                        
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 20) {
                                ForEach(viewModel.tvShowes) { show in
                                    TVShowItemView(
                                        show: show,
                                        itemType: .item,
                                        cornerRadius: 12
                                    )
                                }
                            }
                            .frame(height: 200)
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .scrollIndicators(.hidden)
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            await viewModel.loadMovies()
                            await viewModel.loadPopularTVShow()
                        }
                    } label: {
                        Text("PRESSS")
                    }
                }
            }
             // MARK: - Navigation Tool Bar
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Cine Track")
                        .screenNameStyle()
                }
            }
        }
        .task {
            await viewModel.loadMovies()
            await viewModel.loadPopularTVShow()
        }
    }
}

#Preview {
    let container = AppContainer()
    ContentView(viewModel: container.makeMovieListViewModel())
}
