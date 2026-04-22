//
//  MovieRepositoryImpl.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import Foundation

enum MovieEndpointMapping {
    case popular
    case topRated
    case nowPlaying
    case upcoming
    
    var endpoint: String {
        switch self {
        case .popular:
            APIConstants.Movie.popular
        case .topRated:
            APIConstants.Movie.topRate
        case .nowPlaying:
            APIConstants.Movie.nowPlaying
        case .upcoming:
            APIConstants.Movie.upcoming
        }
    }
}

final class MovieRepositoryImpl: MovieRepository {
    private let apiClient: APIClient
    private let localDataSource: FavoriteLocalDataSource
    
    init(apiClient: APIClient, localDataSource: FavoriteLocalDataSource) {
        self.apiClient = apiClient
        self.localDataSource = localDataSource
    }
    
    func getTrendingMovies(timePeriod: TimePeriod) async throws -> [Movie] {
        let response: MovieResponse = try await apiClient.fetchData(
            endpoint: String(format: APIConstants.Movie.trending, timePeriod.rawValue),
            params: [:]
        )
        return response.results
    }
    
    func fetchPopularMovies(page: Int) async throws -> [Movie] {
        let response: MovieResponse = try await apiClient.fetchData(
            endpoint: APIConstants.Movie.popular,
            params: [
                "page": page
            ]
        )
        return response.results
    }
    
    func fetchMoviesByCategory(page: Int, endpoint: MovieEndpointMapping) async throws -> [Movie] {
        let response: MovieResponse = try await apiClient.fetchData(
            endpoint: endpoint.endpoint,
            params: [
                "page": page
            ]
        )
        return response.results
    }
    
    func fetchMovieDetailById(_ id: Int) async throws -> MovieDetail {
        let idString = String(describing: id)
        return try await apiClient.fetchData(
            endpoint: String(format: APIConstants.Movie.detail, idString),
            params: [:]
        )
    }
    
    func saveFavorite(movie: Movie) throws {
        try localDataSource.save(movie: movie)
    }
    
    func removeAllFavorite() throws {
        try localDataSource.removeAll()
    }
    
    func removeFavorite(movieId: Int) throws {
        try localDataSource.remove(movieId: movieId)
    }
    
    func isFavorite(movieId: Int) throws -> Bool {
        try localDataSource.isFavorite(movieId: movieId)
    }
    
    func getFavorites() throws -> [Movie] {
        try localDataSource.fetchAll()
    }
}
