//
//  MatchesListViewModel.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

final class MatchesListViewModel<Service: MatchServicing>: MatchesListDataSourceable {
    
    @Published var matches: [Match] = []
    private let matchService: Service
    
    init(matchService: Service) {
        self.matchService = matchService
    }
    
    func requestMatches() async {
        do {
            matches = try await matchService.fetchMatches()
        } catch {
            print(error)
        }
    }
    
}
