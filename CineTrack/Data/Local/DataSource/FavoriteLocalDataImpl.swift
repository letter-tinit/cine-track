//
//  FavoriteLocalDataImpl.swift
//  CineTrack
//
//  Created by TiniT on 21/4/26.
//

import SwiftData
import Foundation

enum FavoriteLocalDataError: LocalizedError {
    case saveFailed(NSError)
    case fetchFailed(NSError)
    case movieNotFound(id: Int)

    var errorDescription: String? {
        switch self {
        case .saveFailed(let error):
            return "Failed to save favorite: \(error.localizedDescription)"
        case .fetchFailed(let error):
            return "Failed to fetch favorites: \(error.localizedDescription)"
        case .movieNotFound(let id):
            return "Movie with id \(id) not found in favorites"
        }
    }
}

final class FavoriteLocalDataImpl: FavoriteLocalDataSource {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func save(movie: Movie) throws {
        let entity = FavoriteMapper.toEntity(from: movie)
        context.insert(entity)
        try saveContext()
    }
    
    func remove(movieId: Int) throws {
        let descriptor = FetchDescriptor<FavoriteMovieEntity>()
        
        do {
            let movies = try context.fetch(descriptor)
            guard let movie = movies.first(where: { $0.id == movieId }) else {
                throw FavoriteLocalDataError.movieNotFound(id: movieId)
            }
            context.delete(movie)
            try saveContext()
        } catch let error as FavoriteLocalDataError {
            throw error // re-throw our custom errors as-is
        } catch let error as NSError {
            throw FavoriteLocalDataError.fetchFailed(error)
        }
    }
    
    func fetchAll() throws -> [Movie] {
        let descriptor = FetchDescriptor<FavoriteMovieEntity>()
        
        do {
            let entities = try context.fetch(descriptor)
            return entities.map { FavoriteMapper.toDomain(from: $0) }
        } catch let error as NSError {
            throw FavoriteLocalDataError.fetchFailed(error)
        }
    }
    
    func isFavorite(movieId: Int) throws -> Bool {
        let descriptor = FetchDescriptor<FavoriteMovieEntity>()
        
        do {
            let movies = try context.fetch(descriptor)
            return movies.contains(where: { $0.id == movieId })
        } catch let error as NSError {
            throw FavoriteLocalDataError.fetchFailed(error)
        }
    }
    
    private func saveContext() throws {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch let error as NSError {
            throw FavoriteLocalDataError.saveFailed(error)
        }
    }
}
