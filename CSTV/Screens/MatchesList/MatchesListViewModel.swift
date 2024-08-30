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
            let fetchedMatches = try await matchService.fetchMatches(for: Date.getTodayDateRangeString())
            await MainActor.run {
                matches = fetchedMatches
            }
        } catch {
            print(error)
        }
    }
    
    func requestLeagueSerieDescription(for match: Match) -> String {
        match.league.name + (match.serie.name.isEmpty ? "" : " + \(match.serie.name)")
    }
    
    func requestLeagueURL(for match: Match) -> URL? {
        guard let leagueLogoStringUrl = match.league.imageUrl else { return nil }
        
        return URL(string: leagueLogoStringUrl)
    }
    
}
