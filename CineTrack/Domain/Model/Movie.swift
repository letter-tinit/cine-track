//
//  Movie.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import Foundation

public struct Movie: Decodable, Identifiable {
    public let id: Int
    public let adult: Bool
    public let backdropPath: String?
    public let title: String
    public let originalTitle: String
    public let overview: String
    public let posterPath: String?
    public let mediaType: String
    public let originalLanguage: String
    public let genreIds: [Int]
    public let popularity: Double
    public let releaseDate: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backdropPath = "backdrop_path"
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case genreIds = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
    static let mock = Movie(
        id: 1,
        adult: false,
        backdropPath: "/test.jpg",
        title: "Mock Movie",
        originalTitle: "Mock Movie",
        overview: "This is a mock movie for preview",
        posterPath: "/tVvpFIoteRHNnoZMhdnwIVwJpCA.jpg",
        mediaType: "movie",
        originalLanguage: "en",
        genreIds: [28, 12],
        popularity: 100.0,
        releaseDate: "2026-01-01",
        video: false,
        voteAverage: 8.5,
        voteCount: 1000
    )
    
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}

public struct MovieResponse: Decodable {
    public let results: [Movie]
}
