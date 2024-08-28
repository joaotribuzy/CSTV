//
//  MatchService.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

protocol MatchServicing {
    func fetchMatches() async throws -> [Match]
}

final class MatchService: MatchServicing {
    
    private(set) var networkManager: NetworkManaging
    private let baseUrl = ""
    
    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
    
    func fetchMatches() async throws -> [Match] {
        let url = URL(string: "\(baseUrl)/matches")
        return try await networkManager.performRequest(url: url, type: [Match].self)
    }
    
}
