//
//  MatchService.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

protocol MatchServicing {
    func fetchRunningMatches() async throws -> [Match]
    func fetchUpcomingMatches() async throws -> [Match]
}

final class MatchService: MatchServicing {
    
    private(set) var networkManager: NetworkManaging
    private let baseUrlString = RequestComponents.matchesBaseUrl.rawValue
    private let apiKey = "kruSfdDSRCwrG7A_oqc08KZbCqaYg8iMYJSAKpsfepv0Gj-3wNI"
    
    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchRunningMatches() async throws -> [Match] {
        
        var components = try getBaseRequestComponents()
        components.path.append(RequestComponents.running.rawValue)
        
        return try await networkManager.get(url: components.url, type: [Match].self)
        
    }
    
    func fetchUpcomingMatches() async throws -> [Match] {
        
        var components = try getBaseRequestComponents()
        components.path.append(RequestComponents.upcoming.rawValue)
        
        return try await networkManager.get(url: components.url, type: [Match].self)
        
    }

}

private extension MatchService {
    enum RequestComponents: String {
        case matchesBaseUrl = "https://api.pandascore.co/csgo/matches/"
        case running
        case upcoming
        case token
    }
    
    func getBaseRequestComponents() throws -> URLComponents {
        
        guard let url = URL(string: baseUrlString) else { throw URLError(.badURL) }
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: RequestComponents.token.rawValue, value: apiKey),
            URLQueryItem(name: "sort", value: "begin_at")
        ]
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw URLError(.badURL) }
        
        components.queryItems = queryItems
        
        return components
        
    }
}
