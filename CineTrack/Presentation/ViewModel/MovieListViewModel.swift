//
//  MovieListViewModel.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import Foundation
import Combine

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var tvShowes: [TVShow] = []
    @Published var isTrendingMovieLoading = false
    @Published var isPopularTVShowLoading = false

    private let useCase: MovieListUseCase
    
    init(useCase: MovieListUseCase) {
        self.useCase = useCase
    }
    
    func loadMovies() async {
        isTrendingMovieLoading = true
        defer { isTrendingMovieLoading = false }
        
        do {
            movies = try await useCase.getTrendingMovies()
        } catch {
            print("Error:", error)
        }
    }
    
    func loadPopularTVShow() async {
        isPopularTVShowLoading = true
        defer { isPopularTVShowLoading = false }
        
        do {
            tvShowes = try await useCase.getPopularTVShow()
        } catch {
            print("Error:", error)
        }
    }
}
