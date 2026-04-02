//
//  MovieRowView.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(url: movie.posterURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure:
                    Color.gray
                    
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 80, height: 120)
            .clipped()
            
            Text(movie.title)
        }
    }
}

#Preview {
    MovieRowView(movie: .mock)
}
