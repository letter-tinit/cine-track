//
//  Movie.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import Foundation

public struct MovieResponse: Decodable {
    public let page: UInt
    public let results: [Movie]
    public let totalPages: UInt
    public let totalResults: UInt

    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct Movie: Hashable, Decodable, Identifiable {
    public let id: Int
    public let title: String
    public let originalTitle: String
    public let overview: String
    public let posterPath: String?
    public let backdropPath: String?
    public let genreIDs: [Int]
    public let popularity: Double
    public let releaseDate: String
    public let voteAverage: Double
    public let voteCount: Int
    public let adult: Bool
    public let video: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, overview, popularity, adult, video
        case title
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
    static let mock: Movie = Movie(
        id: 1,
        title: "Inception",
        originalTitle: "Inception",
        overview: "A thief who steals corporate secrets through dream-sharing technology.",
        posterPath: "/in1R2dDc421JxsoRWaIIAqVI2KE.jpg",
        backdropPath: "/in1R2dDc421JxsoRWaIIAqVI2KE.jpg",
        genreIDs: [28, 878],
        popularity: 95.5,
        releaseDate: "2010-07-16",
        voteAverage: 8.8,
        voteCount: 32000,
        adult: false,
        video: false
    )
    
    static let mocks: [Movie] = [
        .mock,
        Movie(
            id: 2,
            title: "The Dark Knight",
            originalTitle: "The Dark Knight",
            overview: "Batman faces the Joker.",
            posterPath: "/in1R2dDc421JxsoRWaIIAqVI2KE.jpg",
            backdropPath: "/in1R2dDc421JxsoRWaIIAqVI2KE.jpg",
            genreIDs: [28, 80],
            popularity: 98.0,
            releaseDate: "2008-07-18",
            voteAverage: 9.0,
            voteCount: 35000,
            adult: false,
            video: false
        )
    ]
    
    static let empty = Movie(
        id: -1,
        title: "",
        originalTitle: "",
        overview: "",
        posterPath: "",
        backdropPath: "",
        genreIDs: [],
        popularity: 0,
        releaseDate: "",
        voteAverage: 0,
        voteCount: 0,
        adult: false,
        video: false
    )
}

extension Movie {
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}

extension Movie {
    init(from detail: MovieDetail) {
        self.id = detail.id
        self.title = detail.title
        self.originalTitle = detail.originalTitle
        
        // Movie requires non-optional → provide fallback
        self.overview = detail.overview ?? ""
        self.posterPath = detail.posterPath
        self.backdropPath = detail.backdropPath
        
        // Convert [Genre] → [Int]
        self.genreIDs = detail.genres.map { $0.id }
        
        self.popularity = detail.popularity ?? 0
        self.releaseDate = detail.releaseDate ?? ""
        self.voteAverage = detail.voteAverage ?? 0
        self.voteCount = detail.voteCount ?? 0
        
        self.adult = detail.adult
        self.video = detail.video
    }
}
