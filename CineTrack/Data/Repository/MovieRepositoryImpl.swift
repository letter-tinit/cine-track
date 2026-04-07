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
        let response: MovieResponse = try await apiClient.fetchData(
            endpoint: APIConstants.Movie.trending,
            params: [:]
        )
        return response.results
    }
    
    func getPopularTVShow() async throws -> [TVShow] {
        let response: TVShowResponse = try await apiClient.fetchData(
            endpoint: APIConstants.TVShow.popular,
            params: [:]
        )
        return response.results
    }
}
