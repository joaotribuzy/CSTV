//
//  NetworkManager.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

protocol NetworkManaging {
    func get<T>(url: URL?, type: T.Type) async throws -> T where T : Decodable
}

final class NetworkManager: NetworkManaging {
    
    private(set) var urlSession: URLSession
    private let timeotInteval: TimeInterval = 10
    private let headerFields = ["accept": "application/json"]
    
    init(urlSession: URLSession) {
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
