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
    
    func requestRunningMatches() async {
        do {
            let runningMatches = try await matchService.fetchRunningMatches()

            DispatchQueue.main.async {
                self.matches = self.matches + runningMatches
            }
        } catch {
            print(error)
        }
    }
    
    func requestUpcomingMatches() async {
        do {
            let upcomingMatches = try await matchService.fetchUpcomingMatches()

            DispatchQueue.main.async {
                self.matches = self.matches + upcomingMatches
            }
        } catch {
            print(error)
        }
    }
    
}
