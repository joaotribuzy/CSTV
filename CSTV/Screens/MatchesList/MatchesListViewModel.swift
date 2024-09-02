//
//  MatchesListViewModel.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

final class MatchesListViewModel: MatchesListDataSourceable {
    
    @Published var matches: [Match] = []
    private let matchService: MatchServicing
    
    init(matchService: MatchServicing) {
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
                .filter { $0.opponents.count >= 2}

            DispatchQueue.main.async {
                self.matches = self.matches + upcomingMatches
            }
        } catch {
            print(error)
        }
    }
    
    func requestDetailViewModel(for match: Match) -> MatchDetailViewModel {
        MatchDetailViewModel(
            match: match,
            playerService: TeamService()
        )
    }
    
}
