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
    var favoriteIds: Set<Int> = []
    var timePeriod: TimePeriod = .day
    
    // MARK: - Repository
    var trendingMovies: [Movie] = []
    var popularMovies: [Movie] = []
    var topRateMovies: [Movie] = []
    var nowPlayingMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var favoritedMovies: [Movie] = []
    
    // MARK: - Callback
    var onHomeRoute: ((HomeRoute) -> Void)?
    
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
    
    func loadTrending() async {
        do {
            self.trendingMovies = try await useCase.getTrendingMovie(timePeriod: timePeriod)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func loadPopular() async {
        do {
            self.popularMovies = try await useCase.getPopularMovie(page: 1)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func loadTopRated() async {
        do {
            self.topRateMovies = try await useCase.getTopRatedMovie(page: 1)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func loadNowPlaying() async {
        do {
            self.nowPlayingMovies = try await useCase.getNowPlayingMovie(page: 1)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func loadUpcoming() async {
        do {
            self.upcomingMovies = try await useCase.getUpcomingMovie(page: 1)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func getMovieDetail(_ id: Int) async {
        guard !isLoading else { return }
        isLoading = true
        
        defer { isLoading = false }
        
        do {
            let result = try await useCase.getMovieDetailById(id)
            onHomeRoute?(.movieDetail(result))
        } catch {
            handleError(error)
        }
    }
    
    func didChangeTimePeriod() {
        loadTask?.cancel()
        loadTask = Task {
            await loadTrending()
        }
    }
    
    func toggleFavorite(movie: Movie, completion: VoidClosure) {
        if isFavorite(movieId: movie.id) {
            removeFavorite(movieId: movie.id, completion: completion)
        } else {
            saveFavorite(movie: movie, completion: completion)
        }
    }
    
    private func saveFavorite(movie: Movie, completion: VoidClosure) {
        do {
            try useCase.saveFavorite(movie: movie)
            completion()
        } catch {
            handleError(error)
        }
    }
    
    private func removeFavorite(movieId: Int, completion: VoidClosure) {
        do {
            try useCase.removeFavorite(movieId: movieId)
            completion()
        } catch {
            handleError(error)
        }
    }
    
    func isFavorite(movieId: Int) -> Bool {
        do {
            return try useCase.isFavorite(movieId: movieId)
        } catch {
            handleError(error)
        }
        
        return false
    }
    
    func loadFavorites(){
        do {
            favoritedMovies = try useCase.getFavorites()
        } catch {
            handleError(error)
        }
    }
    
    func a() {
        print("A")
    }
}
