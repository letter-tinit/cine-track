//
//  MovieDetailScreen.swift
//  CineTrack
//
//  Created by TiniT on 14/4/26.
//

import SwiftUI

struct MovieDetailScreen: View {
    let movie: MovieDetail
    var body: some View {
        let voteAverage = (movie.voteAverage ?? 0) / 2
        
        BaseScreen {
            ScrollView(.vertical, showsIndicators: false) {
                // MARK: - MAIN STACK
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 16) {
                        ScaledAsyncImage(
                            url: movie.posterURL,
                            designWidth: 160,
                            designHeight: 240,
                            cornerRadius: 20
                        )
                        
                        VStack(alignment: .leading) {
                            MovieDescriptionView(
                                label: "Genre",
                                content: movie.genres.map { $0.name }.joined(separator: ", ")
                            )
                            
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
                            
                            Spacer()
                        }
                    }
                    
                    Text(movie.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                    
                    RatingProgressView(voteAverage: voteAverage)
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
                        
                        VStack(alignment: .center) {
                            ScaledAsyncImage(url: movie.productionCompanies[0].logoURL, designWidth: 120, designHeight: 60)
                            Text(movie.productionCompanies[0].name)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.cyan)
                        }
                        .padding(10)
                        .background(.white.opacity(0.7))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )
                        .shadow(radius: 4)
                    }
                    
                    Spacer(minLength: 60)
                }
                .padding(.horizontal, 16)
                
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    MovieDetailScreen(movie: .mock)
}
