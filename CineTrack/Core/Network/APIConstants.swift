//
//  APIConstants.swift
//  CineTrack
//
//  Created by TiniT on 6/4/26.
//

struct APIConstants {
    struct Movie {
        static let trending = "/trending/movie/%@"
        static let popular = "/movie/popular"
        static let topRate = "/movie/top_rated"
        static let nowPlaying = "/movie/now_playing"
        static let upcoming = "/movie/upcoming"
        static let detail = "/movie/%@"
    }
}
