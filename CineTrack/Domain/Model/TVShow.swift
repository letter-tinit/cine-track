//
//  TVShow.swift
//  CineTrack
//
//  Created by TiniT on 6/4/26.
//

import Foundation

// MARK: - Response Model
struct TVShowResponse: Decodable {
    let page: Int
    let results: [TVShow]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - TV Show Model
public struct TVShow: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let originalName: String
    public let originalLanguage: String
    public let overview: String
    public let popularity: Double
    public let voteAverage: Double
    public let voteCount: Int
    public let posterPath: String?
    public let backdropPath: String?
    public let genreIDs: [Int]
    public let adult: Bool
    public let originCountry: [String]
    public let firstAirDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case originalLanguage = "original_language"
        case overview
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case adult
        case originCountry = "origin_country"
        case firstAirDate = "first_air_date"
    }
}

extension TVShow {
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
