//
//  MainTabScreen.swift
//  CineTrack
//
//  Created by TiniT on 7/4/26.
//

import SwiftUI
import SwiftData

struct MainTabScreen: View {
    @State private var activeTab: AppTab = .home
    @State private var isExpanded: Bool = false
    @State private var homeRouter = HomeRouter()
    @State private var searchRouter = SearchRouter()
    @State private var favoriteRouter = FavoriteRouter()

    var tintColor: Color {
        switch activeTab {
        case .home: return .teal
        case .search: return .purple
        case .favorite: return .red
        case .profile: return .mint
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                Tab(AppTab.home.rawValue, systemImage: AppTab.home.symbolImage, value: .home) {
                    AppNavigationStack(path: $homeRouter.path) {
                        HomeScreen()
                            .environment(homeRouter)
                    } destination: { (route: HomeRoute) in
                        switch route {
                        case .movieDetail:
                            MovieDetailScreen()
                        }
                    }
                }
                
                Tab(AppTab.search.rawValue, systemImage: AppTab.search.symbolImage, value: .search) {
                    NavigationStack(path: $homeRouter.path) {
                        EmptyView()
                    }
                }
                
                Tab(AppTab.favorite.rawValue, systemImage: AppTab.favorite.symbolImage, value: .favorite) {
                    AppNavigationStack(path: $favoriteRouter.path) {
                        FavoriteScreen()
                            .environment(favoriteRouter)
                    } destination: { (route: FavoriteRoute) in
                        switch route {
                        case .movieDetail:
                            MovieDetailScreen()
                        }
                    }
                }
                
                Tab(AppTab.profile.rawValue, systemImage: AppTab.profile.symbolImage, value: .profile) {
                    NavigationStack(path: $homeRouter.path) {
                        EmptyView()
                    }
                }
            }
            .tint(tintColor)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    return MainTabScreen()
        .environment(AppContainer().makeMovieStore())
}
