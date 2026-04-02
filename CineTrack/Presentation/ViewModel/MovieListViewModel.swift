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
    @Published var isLoading = false
    
    private let useCase: MovieListUseCase
    
    init(useCase: MovieListUseCase) {
        self.useCase = useCase
    }
    
    func loadMovies() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            movies = try await useCase.getTrendingMovies()
        } catch {
            print("Error:", error)
        }
    }
}
