//
//  PlayerService.swift
//  CSTV
//
//  Created by João Tribuzy on 01/09/24.
//

import Foundation

protocol PlayerServicing {
    func fetchPlayers(fromTeam id: Int) async throws -> [Player]
}

final class PlayerService: PlayerServicing {
    
    private(set) var networkManager: NetworkManaging
    private let baseUrlString = RequestComponents.playersBaseUrl.rawValue
    private let apiKey = "kruSfdDSRCwrG7A_oqc08KZbCqaYg8iMYJSAKpsfepv0Gj-3wNI"
    
    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
    
    func fetchPlayers(fromTeam id: Int) async throws -> [Player] {
        var components = try getBaseRequestComponents()
        
        components.queryItems?.append(
            URLQueryItem(name: RequestComponents.filterById.rawValue, value: String(id))
        )
        
        return try await networkManager.get(url: components.url, type: [Player].self)
    }
}

private extension PlayerService {
    enum RequestComponents: String {
        case playersBaseUrl = "https://api.pandascore.co/csgo/teams"
        case token
        case filterById = "filter[id]"
    }
    
    func getBaseRequestComponents() throws -> URLComponents {
        
        guard let url = URL(string: baseUrlString) else { throw URLError(.badURL) }
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: RequestComponents.token.rawValue, value: apiKey),
        ]
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw URLError(.badURL) }
        
        components.queryItems = queryItems
        
        return components
    }
}
