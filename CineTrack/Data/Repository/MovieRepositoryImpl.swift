//
//  MovieRepositoryImpl.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

final class MovieRepositoryImpl: MovieRepository {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getTrendingMovies() async throws -> [Movie] {
        try await apiClient.fetchTrendingMovies()
    }
}
