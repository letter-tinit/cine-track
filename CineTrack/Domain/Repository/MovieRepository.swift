//
//  MovieRepository.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

protocol MovieRepository {
    func getTrendingMovies(timePeriod: TimePeriod) async throws -> [Movie]
    func fetchMoviesByCategory(page: Int, endpoint: MovieEndpointMapping) async throws -> [Movie]
    func fetchMovieDetailById(_ id: Int) async throws -> MovieDetail
    func saveFavorite(movie: Movie) throws
    func removeFavorite(movieId: Int) throws
    func isFavorite(movieId: Int) throws -> Bool
    func getFavorites() throws -> [Movie]
}
