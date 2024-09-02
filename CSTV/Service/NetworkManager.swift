//
//  NetworkManager.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

protocol NetworkManaging {
    func get<T>(url: URL?, type: T.Type) async throws -> T where T : Decodable
    func getEncodedUrlString(for url: URL?) async throws -> String
}

final class NetworkManager: NetworkManaging {
    
    static var shared = NetworkManager()
    
    private(set) var urlSession: URLSession
    private let timeotInteval: TimeInterval = 10
    private let headerFields = ["accept": "application/json"]
    
    private init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func get<T>(url: URL?, type: T.Type) async throws -> T where T : Decodable {
        
        guard let url = url else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethod.get.rawValue
        request.timeoutInterval = timeotInteval
        request.allHTTPHeaderFields = headerFields
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
        
    }
    
    func getEncodedUrlString(for url: URL?) async throws -> String {
        
        guard let url = url else { throw NetworkError.badUrl }
        
        let (data, _) = try await urlSession.data(from: url)
        
        return data.base64EncodedString()
    }
    
}

private extension NetworkManager {
    
    enum NetworkError: Error {
        case badUrl
        case requestFailed
        case decodingFailed
    }
    
    enum NetworkMethod: String {
        case get = "GET"
    }
    
}
