//
//  TeamService.swift
//  CSTV
//
//  Created by João Tribuzy on 01/09/24.
//

import Foundation

protocol TeamServicing {
    func fetch(team id: Int) async throws -> Team
}

final class TeamService: TeamServicing {
    
    private(set) var networkManager: NetworkManaging
    private let baseUrlString = RequestComponents.playersBaseUrl.rawValue
    private let apiKey = "kruSfdDSRCwrG7A_oqc08KZbCqaYg8iMYJSAKpsfepv0Gj-3wNI"
    
    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetch(team id: Int) async throws -> Team {
        var components = try getBaseRequestComponents()
        
        components.queryItems?.append(
            URLQueryItem(name: RequestComponents.filterById.rawValue, value: String(id))
        )
        
        return try await networkManager.get(url: components.url, type: [Team].self)[0]
    }
}

private extension TeamService {
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
