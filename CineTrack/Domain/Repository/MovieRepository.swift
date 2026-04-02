//
//  MovieRepository.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

protocol MovieRepository {
    func getTrendingMovies() async throws -> [Movie]
}
