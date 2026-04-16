//
//  APIClient.swift
//  CineTrack
//
//  Created by TiniT on 2/4/26.
//

import Foundation

enum APIError: Error {
    case badURL
    case network(Error)
    case decoding(Error)
    case apiError(message: String, code: Int)
    case unknown
}

struct TMDBErrorResponse: Decodable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
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
        // MARK: - Create URL Component
        guard var components = URLComponents(string: baseURL + endpoint) else {
            throw APIError.badURL
        }
        
        var queryItems = params.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        
        components.queryItems = queryItems
        
        // MARK: - Create final URL from URL Component
        guard let url = components.url else {
            throw APIError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let data: Data
        let response: URLResponse
        
        // MARK: - Fetch data from API
        do {
            (data, response) = try await URLSession.shared.data(for: request)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response ---------------------\(endpoint)--------------------\n\(jsonString)")
            }
        } catch {
            throw APIError.network(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        
        // MARK: - Handle Error from Server
        guard (200..<300).contains(httpResponse.statusCode) else {
            if let apiError = try? JSONDecoder().decode(TMDBErrorResponse.self, from: data) {
                throw APIError.apiError(message: apiError.statusMessage, code: apiError.statusCode)
            } else {
                throw APIError.apiError(
                    message: "Unknown server error",
                    code: httpResponse.statusCode
                )
            }
        }
        
        // MARK: - Success Decoded Case
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }
}
