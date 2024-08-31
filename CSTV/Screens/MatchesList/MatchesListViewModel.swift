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
            let runningMatches = try await matchService.fetchRunningMatches()
                .sorted { $0.beginAt < $1.beginAt }
            let upcomingMatches = try await matchService.fetchUpcomingMatches()
                .filter { !$0.status.isCanceled() }
                .sorted { $0.beginAt < $1.beginAt }
            await MainActor.run {
                matches = runningMatches + upcomingMatches
            }
        } catch {
            print(error)
        }
    }
    
}
