//
//  MovieDetailScreen.swift
//  CineTrack
//
//  Created by TiniT on 14/4/26.
//

import SwiftUI

struct MovieDetailScreen: View {
    @Environment(MovieStore.self) private var movieStore
    let movie: MovieDetail
    
    @State private var isFavorited: Bool = false
    var body: some View {
        BaseScreen(
            screenTitle: movie.title
        ) {
            ZStack(alignment: .top) {
                // MARK: - Backdrop
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        BackdropAsyncImage(
                            url: movie.backdropURL,
                            designHeight: 200,
                        )
                        
                        Spacer()
                    }
                }
                .scrollDisabled(true)
                .scrollEdgeEffectStyle(.soft, for: .all)
                .ignoresSafeArea()

                // MARK: - Content
                ScrollView(.vertical, showsIndicators: false) {
                    // MARK: - MAIN STACK
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 16) {
                            // MARK: - Poster
                            ScaledAsyncThumnailImage(
                                url: movie.posterURL,
                                designWidth: 160,
                                designHeight: 240,
                                cornerRadius: 20
                            )
                            
                            // MARK: - Detail
                            VStack(alignment: .leading) {
                                MovieDescriptionView(
                                    label: "Status",
                                    content: movie.status ?? ""
                                )
                                
                                MovieDescriptionView(
                                    label: "Date",
                                    content: movie.releaseDate ?? ""
                                )
                                
                                MovieDescriptionView(
                                    label: "Runtime",
                                    content: "\(movie.runtime ?? 1)"
                                )
                                
                                MovieDescriptionView(
                                    label: "Revenue",
                                    content: "\(movie.revenue ?? 1)"
                                )
                                
                                MovieDescriptionView(
                                    label: "Genre",
                                    content: movie.genres.map { $0.name }.joined(separator: ", ")
                                )
                                
                                Spacer()
                            }
                        }
                        
                        // MARK: - Description
                        Text(movie.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.top, 10)
                        
                        RatingProgressView(voteAverage: movie.ratingValue)
                            .padding(.top, 10)
                        
                        Text(movie.overview ?? "")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .padding(.top, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Companies")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 16) {
                                    ForEach(movie.productionCompanies, id: \.self) { company in
                                        ScaledAsyncThumnailImage(url: company.logoURL, designWidth: 120, designHeight: 60)
                                            .padding(10)
                                            .background(.white)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 10)
                                            )
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                        }
                        
                        Spacer(minLength: 90)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .foregroundStyle(.white)
        .toolbarVisibility(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Action
                } label: {
                    Image(systemName: "arrow.down")
                }
            }
            
            ToolbarSpacer(placement: .topBarTrailing)
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation(.spring(duration: 0.3)) {
                        movieStore.toggleFavorite(movie: Movie(from: movie)) {
                            isFavorited.toggle()
                        }
                    }
                } label: {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                }
                .foregroundStyle(isFavorited ? .red : .black)
                .scaleEffect(isFavorited ? 1.2 : 1)
            }
        }
        .onAppear {
            isFavorited = movieStore.isFavorite(movieId: movie.id)
        }
    }
    
    @MainActor
    func action() {
        
    }
}

#Preview {
    MovieDetailScreen(movie: .mock)
}
