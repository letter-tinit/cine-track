//
//  MovieListUseCase.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import Foundation

public protocol MovieListUseCase {
    func getTrendingMovies() async throws -> [Movie]
}

final class MovieListUseCaseImpl: MovieListUseCase {
    private let repository: MovieRepository
    
    public init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func getTrendingMovies() async throws -> [Movie] {
        try await repository.getTrendingMovies()
    }
}
