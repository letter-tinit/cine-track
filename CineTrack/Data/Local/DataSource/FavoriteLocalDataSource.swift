//
//  FavoriteLocalDataSource.swift
//  CineTrack
//
//  Created by TiniT on 21/4/26.
//

protocol FavoriteLocalDataSource {
    func save(movie: Movie) throws
    func remove(movieId: Int) throws
    func removeAll() throws
    func fetchAll() throws -> [Movie]
    func isFavorite(movieId: Int) throws -> Bool
}
