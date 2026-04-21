//
//  AppContainer.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import SwiftData

final class AppContainer {
    let container: ModelContainer
    let context: ModelContext
    
    // MARK: - Core
    lazy var apiClient: APIClient = TMDBAPIClient()
    
    init() {
        self.container = Persistence.makeContainer()
        self.context = container.mainContext
    }
    
    // MARK: - Local
    lazy var localDataSource: FavoriteLocalDataSource = FavoriteLocalDataImpl(context: context)
    
    // MARK: - Repository
    lazy var movieRepository: MovieRepository = MovieRepositoryImpl(
        apiClient: apiClient,
        localDataSource: localDataSource
    )
    
    // MARK: -  UseCase
    lazy var movieListUseCase: MovieUseCase = MovieUseCaseImpl(repository: movieRepository)
    
    func makeMovieStore() -> MovieStore {
        MovieStore(useCase: movieListUseCase)
    }
}
