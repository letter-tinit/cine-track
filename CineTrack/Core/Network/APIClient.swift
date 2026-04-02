//
//  APIClient.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import Foundation

protocol APIClient {
    func fetchTrendingMovies() async throws -> [Movie]
}

final class TMDBAPIClient: APIClient {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "86ea8e381d29c2c0119f05817617c1c3"
    
    func fetchTrendingMovies() async throws -> [Movie] {
        let endpoint = "/trending/movie/day"
        
        guard var components = URLComponents(string: baseURL + endpoint) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response -----------------------------------------\n\(jsonString)")
        }
        
        let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)

        return decoded.results
    }
}
