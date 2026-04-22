//
//  FavoriteScreen.swift
//  CineTrack
//
//  Created by TiniT on 21/4/26.
//

import SwiftUI
import SwiftData
import Lottie

struct FavoriteScreen: View {
    @Environment(MovieStore.self) private var movieStore
    @Environment(FavoriteRouter.self) private var router
    @State private var isWarningPresented: Bool = false
    @State private var isRemindPresented: Bool = false
    
    var body: some View {
        BaseScreen(
            screenTitle: "Favorite"
        ) {
            // MARK: - Content
            ZStack {
                if movieStore.favoritedMovies.isEmpty {
                    VStack(spacing: 0) {
                        LottieView(animation: .named("empty"))
                            .playing()
                            .looping()
                            .animationSpeed(1.5)
                            .frame(width: 300, height: 300)
                        
                        Text("No favorite movies yet.")
                            .font(.title2)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(Color(hex: "64B68F"))
                    }
                }
                
                List {
                    ForEach(movieStore.favoritedMovies, id: \.self) { movie in
                        FavoriteRowView(movie: movie)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                            .swipeActions {
                                Button {
                                    movieStore.toggleFavorite(movie: movie)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                            .onTapGesture {
                                Task {
                                    await movieStore.getMovieDetail(movie.id) {
                                        router.push(.movieDetail)
                                    }
                                }
                            }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .toolbar {
                    if !movieStore.favoritedMovies.isEmpty {
                        ToolbarItem {
                            Button {
                                isWarningPresented = true
                            } label: {
                                Image(systemName: "trash")
                            }
                            .foregroundStyle(.red)
                        }
                    }
                }
            }
        }
        .foregroundStyle(.white)
        .onAppear {
            movieStore.loadFavorites()
        }
        .alertView(
            isPresented: $isWarningPresented,
            alertType: .warning("Are you sure to remove all movies from favorite. This action can't be undone."),
            primaryAction: AlertButton(title: "Remove All") {
                movieStore.removeAllFavorited()
                isWarningPresented = false
            },
            secondaryAction: AlertButton(title: "Close") {
                isWarningPresented = false
            }
        )
    }
}

#Preview {
    FavoriteScreen()
}
