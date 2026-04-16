//
//  AppContainer.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

final class AppContainer {
    // MARK: - Core
    lazy var apiClient: APIClient = TMDBAPIClient()
    
    // MARK: - Repository
    lazy var movieRepository: MovieRepository = MovieRepositoryImpl(apiClient: apiClient)
    
    // MARK: -  UseCase
    lazy var movieListUseCase: MovieUseCase = MovieUseCaseImpl(repository: movieRepository)
    
    func makeMovieStore() -> MovieStore {
        MovieStore(useCase: movieListUseCase)
    }
}
