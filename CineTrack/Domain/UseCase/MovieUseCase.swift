//
//  MovieListUseCase.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import Foundation

public protocol MovieUseCase {
    func getTrendingMovie(timePeriod: TimePeriod) async throws -> [Movie]
    func getPopularMovie(page: Int) async throws -> [Movie]
    func getTopRatedMovie(page: Int) async throws -> [Movie]
    func getNowPlayingMovie(page: Int) async throws -> [Movie]
    func getUpcomingMovie(page: Int) async throws -> [Movie]
    func getMovieDetailById(_ id: Int) async throws -> MovieDetail
}

final class MovieUseCaseImpl: MovieUseCase {
    private let repository: MovieRepository
    
    public init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func getTrendingMovie(timePeriod: TimePeriod) async throws -> [Movie] {
        try await repository.getTrendingMovies(timePeriod: timePeriod)
    }
    
    func getPopularMovie(page: Int) async throws -> [Movie] {
        try await repository.fetchMoviesByCategory(page: page, endpoint: MovieEndpointMapping.popular)
    }
    
    func getTopRatedMovie(page: Int) async throws -> [Movie] {
        try await repository.fetchMoviesByCategory(page: page, endpoint: MovieEndpointMapping.topRated)
    }
    
    func getNowPlayingMovie(page: Int) async throws -> [Movie] {
        try await repository.fetchMoviesByCategory(page: page, endpoint: MovieEndpointMapping.nowPlaying)
    }
    
    func getUpcomingMovie(page: Int) async throws -> [Movie] {
        try await repository.fetchMoviesByCategory(page: page, endpoint: MovieEndpointMapping.upcoming)
    }
    
    func getMovieDetailById(_ id: Int) async throws -> MovieDetail {
        try await repository.fetchMovieDetailById(id)
    }
}
