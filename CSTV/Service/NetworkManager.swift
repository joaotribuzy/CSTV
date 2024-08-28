//
//  NetworkManager.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

protocol NetworkManaging {
    func performRequest<T>(url: URL?, type: T.Type) async throws -> T where T : Decodable
}

enum NetworkError: Error {
    case badUrl
    case requestFailed
    case decodingFailed
}

final class NetworkManager: NetworkManaging {
    
    private(set) var urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func performRequest<T>(url: URL?, type: T.Type) async throws -> T where T : Decodable {
        
        guard let requestUrl = url else {
            throw NetworkError.badUrl
        }
        
        let (data, response) = try await urlSession.data(from: requestUrl)
        
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
