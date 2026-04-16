//
//  MovieView.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import SwiftUI

enum ItemType {
    case largeItem
    case item
    
    var designWidth: CGFloat {
        switch self {
        case .largeItem:
            160
        case .item:
            120
        }
    }
    
    var designHeight: CGFloat {
        switch self {
        case .largeItem:
            240
        case .item:
            200
        }
    }
}

struct MovieView: View {
    let movie: Movie
    var itemType: ItemType = .item
    var cornerRadius: CGFloat = 0
    
    @Environment(MovieStore.self) private var movieStore

    var body: some View {
        ScaledAsyncImage(
            url: movie.posterURL,
            designWidth: itemType.designWidth,
            designHeight: itemType.designHeight,
            cornerRadius: cornerRadius
        )
        .onTapGesture {
            Task {
                await movieStore.getMovieDetail(movie.id)
            }
        }
    }
}

#Preview {
    MovieView(movie: Movie.mock)
}
