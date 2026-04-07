//
//  APIClient.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import Foundation

enum APIError: Error {
    case badURL
    case badResponse
    case decodingError
}

protocol APIClient {
    func fetchData<T: Decodable>(endpoint: String, params: [String: Any]) async throws -> T
}

final class TMDBAPIClient: APIClient {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "86ea8e381d29c2c0119f05817617c1c3"
    
    func fetchData<T: Decodable>(
        endpoint: String,
        params: [String: Any] = [:]
    ) async throws -> T {
        guard var components = URLComponents(string: baseURL + endpoint) else {
            throw APIError.badURL
        }
        
        if params.isEmpty {
            components.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey)
            ]
        } else {
            components.queryItems = params.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
            components.queryItems?.append(
                URLQueryItem(name: "api_key", value: apiKey)
            )
        }
        
        
        guard let url = components.url else {
            throw APIError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response -----------------------------------------\n\(jsonString)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.badResponse
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            print("Decoding error", error.localizedDescription)
            throw APIError.decodingError
        }
    }
}
