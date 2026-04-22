//
//  MovieListViewModel.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import Foundation
import Combine
import Observation

@MainActor
@Observable
final class MovieStore: BaseStore {
    var timePeriod: TimePeriod = .day {
        didSet {
            didChangeTimePeriod()
        }
    }
    
    // MARK: - Repository
    var trendingMovies: [Movie] = []
    var popularMovies: [Movie] = []
    var topRateMovies: [Movie] = []
    var nowPlayingMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var favoritedMovies: [Movie] = []
    var selectedMovieDetail: MovieDetail = .mock
    
    // MARK: - PRIVATE
    private let useCase: MovieUseCase
    private var cancellables = Set<AnyCancellable>()
    private var loadTask: Task<Void, Never>?
    
    init(useCase: MovieUseCase) {
        self.useCase = useCase
    }
    
    func loadHomeData() async {
        guard !isLoading else { return }
        isLoading = true
        
        defer { isLoading = false }
        
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.loadTrending()
            }
            
            group.addTask {
                await self.loadPopular()
            }
            
            group.addTask {
                await self.loadTopRated()
            }
            
            group.addTask {
                await self.loadNowPlaying()
            }
            
            group.addTask {
                await self.loadUpcoming()
            }
        }
    }
    
    func getMovieDetail(_ id: Int, onSuccess: VoidClosure) async {
        guard !isLoading else { return }
        isLoading = true
        
        defer { isLoading = false }
        
        do {
            let movieDetail = try await useCase.getMovieDetailById(id)
            selectedMovieDetail = movieDetail
            selectedMovieDetail.isFavorited = isFavorite(movieId: id)
            onSuccess()
        } catch {
            handleError(error)
        }
    }
    
    func toggleFavorite(movie: Movie) {
        if isFavorite(movieId: movie.id) {
            removeFavorite(movieId: movie.id)
        } else {
            saveFavorite(movie: movie)
        }
    }
    
    func loadFavorites() {
        do {
            favoritedMovies = try useCase.getFavorites()
        } catch {
            handleError(error)
        }
    }
    
    func removeAllFavorited() {
        do {
            try useCase.removeAllFavorite()
            favoritedMovies = []
        } catch {
            handleError(error)
        }
    }
}

// MARK: - Private HomeScreen Helper
extension MovieStore {
    private func loadTrending() async {
        do {
            self.trendingMovies = try await useCase.getTrendingMovie(timePeriod: timePeriod)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    private func loadPopular() async {
        do {
            self.popularMovies = try await useCase.getPopularMovie(page: 1)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    private func loadTopRated() async {
        do {
            self.topRateMovies = try await useCase.getTopRatedMovie(page: 1)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    private func loadNowPlaying() async {
        do {
            self.nowPlayingMovies = try await useCase.getNowPlayingMovie(page: 1)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    private func loadUpcoming() async {
        do {
            self.upcomingMovies = try await useCase.getUpcomingMovie(page: 1)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    private func didChangeTimePeriod() {
        loadTask?.cancel()
        loadTask = Task {
            await loadTrending()
        }
    }
}

// MARK: - Favorited Helper
extension MovieStore {
    private func saveFavorite(movie: Movie) {
        do {
            try useCase.saveFavorite(movie: movie)
            selectedMovieDetail.isFavorited.toggle()
        } catch {
            handleError(error)
        }
    }
    
    private func removeFavorite(movieId: Int) {
        do {
            try useCase.removeFavorite(movieId: movieId)
            favoritedMovies.removeAll() { $0.id == movieId }
            selectedMovieDetail.isFavorited.toggle()
        } catch {
            handleError(error)
        }
    }
    
    private func isFavorite(movieId: Int) -> Bool {
        do {
            return try useCase.isFavorite(movieId: movieId)
        } catch {
            handleError(error)
        }
        
        return false
    }
}
