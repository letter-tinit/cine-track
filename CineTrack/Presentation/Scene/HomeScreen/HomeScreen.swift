//
//  HomeScreen.swift
//  CineTrack
//
//  Created by TiniT on 31/3/26.
//

import SwiftUI
import Lottie

enum AppTab: String, MorphingTabProtocol {
    case home = "Home"
    case search = "Search"
    case favorite = "Favorite"
    case profile = "Profile"
    
    var symbolImage: String {
        return switch self {
        case .home:
            "house"
        case .search:
            "magnifyingglass"
        case .favorite:
            "heart"
        case .profile:
            "person"
        }
    }
}

public enum TimePeriod: String, CaseIterable, SegmentItem {
    case day
    case week
    
    var title: String {
        switch self {
        case .day: "Day"
        case .week: "Week"
        }
    }
}

struct HomeScreen: View {
    // MARK: - Environment
    @Environment(MovieStore.self) private var movieStore
    @Environment(HomeRouter.self) private var router: HomeRouter
    
    var body: some View {
        // Explicit bindable mark
        @Bindable var movieStore = movieStore
        @Bindable var router = router
        
        BaseScreen(
            screenTitle: "Cine Track",
            isLoading: $movieStore.isLoading
        ) {
            // MARK: - Container
            ScrollView(.vertical) {
                VStack {
                    // MARK: - TRENDING
                    HomeSectionView(
                        title: "Trending",
                        items: movieStore.trendingMovies,
                        selectionPeriod: $movieStore.timePeriod
                    ) { movie in
                        MovieView(
                            movie: movie,
                            itemType: .largeItem,
                            cornerRadius: 16
                        )
                    }
                    
                    // MARK: - POPULAR
                    HomeSectionView(
                        title: "Popular",
                        items: movieStore.popularMovies,
                    ) { movie in
                        MovieView(
                            movie: movie,
                            itemType: .item,
                            cornerRadius: 16
                        )
                    }
                    
                    // MARK: - TOP RATED
                    HomeSectionView(
                        title: "Top Rated",
                        items: movieStore.topRateMovies,
                    ) { movie in
                        MovieView(
                            movie: movie,
                            itemType: .item,
                            cornerRadius: 16
                        )
                    }
                    // MARK: - NOW PLAYING
                    HomeSectionView(
                        title: "Now Playing",
                        items: movieStore.nowPlayingMovies,
                    ) { movie in
                        MovieView(
                            movie: movie,
                            itemType: .item,
                            cornerRadius: 16
                        )
                    }
                    
                    // MARK: - UPCOMING
                    HomeSectionView(
                        title: "Up coming",
                        items: movieStore.upcomingMovies,
                    ) { movie in
                        MovieView(
                            movie: movie,
                            itemType: .item,
                            cornerRadius: 16
                        )
                    }
                    
                    Spacer()
                }
            }
            .errorAlert($movieStore.errorMessage)
        }
        // MARK: - LOAD DATA
        .task {
            await movieStore.loadHomeData()
        }
    }
}

// MARK: - Preview
#Preview {
    let homeRouter = AppRouter<HomeRoute>()
    NavigationStack {
        HomeScreen()
            .environment(homeRouter)
    }
}
