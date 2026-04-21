//
//  FavoriteMovieEntity.swift
//  CineTrack
//
//  Created by TiniT on 21/4/26.
//

import SwiftData
import Foundation

@Model
final class FavoriteMovieEntity {
    @Attribute(.unique) var id: Int
    var title: String
    var posterURL: URL?
    var originalTitle: String
    var overview: String
    var posterPath: String?
    var backdropPath: String?
    var genreIDs: [Int]
    var popularity: Double
    var releaseDate: String
    var voteAverage: Double
    var voteCount: Int
    var adult: Bool
    var video: Bool
    
    init(id: Int, title: String, posterURL: URL? = nil, originalTitle: String, overview: String, posterPath: String? = nil, backdropPath: String? = nil, genreIDs: [Int], popularity: Double, releaseDate: String, voteAverage: Double, voteCount: Int, adult: Bool, video: Bool) {
        self.id = id
        self.title = title
        self.posterURL = posterURL
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.genreIDs = genreIDs
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.adult = adult
        self.video = video
    }
}
