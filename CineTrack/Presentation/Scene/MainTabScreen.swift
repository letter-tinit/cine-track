//
//  MainTabScreen.swift
//  CineTrack
//
//  Created by TiniT on 7/4/26.
//

import SwiftUI

struct MainTabScreen: View {
    @State private var activeTab: AppTab = .home
    @State private var isExpanded: Bool = false
    @State private var homeRouter = HomeRouter()
    @State private var searchRouter = SearchRouter()

    init() {
        /// Hidden system Tabbar for using custom
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                NavigationStack(path: $homeRouter.path) {
                    HomeScreen()
                        .environment(homeRouter)
                }
                .tag(AppTab.home)

                SearchScreen()
                    .tag(AppTab.search)
                    .environment(searchRouter)
                
                Rectangle().foregroundStyle(.clear)
                    .tag(AppTab.favorite)
                    .background(.red)
                
                Rectangle().foregroundStyle(.clear)
                    .tag(AppTab.profile)
            }
            
            MorphingTabBar(activeTab: $activeTab, isExpanded: $isExpanded)
                .padding(.horizontal, 20)
                .padding(.bottom, 25)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainTabScreen()
        .environment(AppContainer().makeMovieStore())
}
