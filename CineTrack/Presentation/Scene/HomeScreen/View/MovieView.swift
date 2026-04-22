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
            designWidth/AppConstants.Ratio.posterRatio
        case .item:
            designWidth/AppConstants.Ratio.posterRatio
        }
    }
}

struct MovieView: View {
    let movie: Movie
    var itemType: ItemType = .item
    var cornerRadius: CGFloat = 0
    
    @Environment(MovieStore.self) private var movieStore
    @Environment(HomeRouter.self) private var router

    var body: some View {
        ScaledAsyncThumnailImage(
            url: movie.posterURL,
            designWidth: itemType.designWidth,
            designHeight: itemType.designHeight,
            cornerRadius: cornerRadius
        )
        .onTapGesture {
            Task {
                await movieStore.getMovieDetail(movie.id) {
                    router.push(.movieDetail)
                }
            }
        }
    }
}

#Preview {
    MovieView(movie: Movie.mock)
}
