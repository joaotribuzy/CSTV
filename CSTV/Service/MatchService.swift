//
//  MatchService.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

protocol MatchServicing {
    func fetchMatches(for date: String) async throws -> [Match]
}

final class MatchService: MatchServicing {
    
    private(set) var networkManager: NetworkManaging
    private let baseUrlString = RequestComponents.matchesBaseUrl.rawValue
    private let apiKey = "kruSfdDSRCwrG7A_oqc08KZbCqaYg8iMYJSAKpsfepv0Gj-3wNI"
    
    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
    
    func fetchMatches(for dateRange: String) async throws -> [Match] {
        
        guard let url = URL(string: baseUrlString) else { throw URLError(.badURL) }
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: RequestComponents.beginAtRange.rawValue, value: dateRange),
            URLQueryItem(name: RequestComponents.token.rawValue, value: apiKey),
        ]
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw URLError(.badURL) }
        
        components.queryItems = queryItems
        
        return try await networkManager.get(url: components.url, type: [Match].self)
    }
    
}

private extension MatchService {
    enum RequestComponents: String {
        case matchesBaseUrl = "https://api.pandascore.co/csgo/matches"
        case token
        case beginAtRange = "range[begin_at]"
    }
}
