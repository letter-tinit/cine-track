//
//  MovieItemView.swift
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

struct MovieItemView: View {
    let movie: Movie
    var itemType: ItemType = .item
    var cornerRadius: CGFloat = 0
    
    var body: some View {
        ScaledAsyncImage(
            url: movie.posterURL,
            designWidth: itemType.designWidth,
            designHeight: itemType.designHeight,
            cornerRadius: cornerRadius
        )
    }
}

#Preview {
    MovieItemView(movie: .mock)
}

struct TVShowItemView: View {
    let show: TVShow
    var itemType: ItemType = .item
    var cornerRadius: CGFloat = 0
    
    var body: some View {
        ScaledAsyncImage(
            url: show.posterURL,
            designWidth: itemType.designWidth,
            designHeight: itemType.designHeight,
            cornerRadius: cornerRadius
        )
    }
}
