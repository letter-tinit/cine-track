//
//  MovieDetailScreen.swift
//  CineTrack
//
//  Created by TiniT on 14/4/26.
//

import SwiftUI

struct MovieDetailScreen: View {
    @Environment(MovieStore.self) private var movieStore
    
    var body: some View {
        @State var isFavorited: Bool = movieStore.selectedMovieDetail.isFavorited
        BaseScreen(
            screenTitle: movieStore.selectedMovieDetail.title
        ) {
            ZStack(alignment: .top) {
                // MARK: - Backdrop
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        BackdropAsyncImage(
                            url: movieStore.selectedMovieDetail.backdropURL,
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
                                url: movieStore.selectedMovieDetail.posterURL,
                                designWidth: 160,
                                designHeight: 240,
                                cornerRadius: 20
                            )
                            
                            // MARK: - Detail
                            VStack(alignment: .leading) {
                                MovieDescriptionView(
                                    label: "Status",
                                    content: movieStore.selectedMovieDetail.status ?? ""
                                )
                                
                                MovieDescriptionView(
                                    label: "Date",
                                    content: movieStore.selectedMovieDetail.releaseDate ?? ""
                                )
                                
                                MovieDescriptionView(
                                    label: "Runtime",
                                    content: "\(movieStore.selectedMovieDetail.runtime ?? 1)"
                                )
                                
                                MovieDescriptionView(
                                    label: "Revenue",
                                    content: "\(movieStore.selectedMovieDetail.revenue ?? 1)"
                                )
                                
                                MovieDescriptionView(
                                    label: "Genre",
                                    content: movieStore.selectedMovieDetail.genres.map { $0.name }.joined(separator: ", ")
                                )
                                
                                Spacer()
                            }
                        }
                        
                        // MARK: - Description
                        Text(movieStore.selectedMovieDetail.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.top, 10)
                        
                        RatingProgressView(voteAverage: movieStore.selectedMovieDetail.ratingValue, voteCount: movieStore.selectedMovieDetail.voteCount ?? 0)
                            .padding(.top, 10)
                        
                        Text(movieStore.selectedMovieDetail.overview ?? "")
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
                                    ForEach(movieStore.selectedMovieDetail.productionCompanies, id: \.self) { company in
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
                        movieStore.toggleFavorite(movie: Movie(from: movieStore.selectedMovieDetail))
                    }
                } label: {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                }
                .foregroundStyle(isFavorited ? .red : .black)
                .scaleEffect(isFavorited ? 1.2 : 1)
            }
        }
        .tint(.white)
    }
    
    @MainActor
    func action() {
        
    }
}

#Preview {
    MovieDetailScreen()
}
