//
//  MatchDetailViewModel.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import Foundation

final class MatchDetailViewModel: MatchDetailDataSourceable {
    
    @Published var match: Match
    @Published var leadingPlayes: [Player] = []
    @Published var trailingPlayes: [Player] = []
    
    private let playerService: TeamServicing
    
    init(match: Match, playerService: TeamService) {
        self.match = match
        self.playerService = playerService
    }
    
    func requestTeamData() async {
        do {
            let leadingTeam = try await playerService.fetch(team: match.opponents[0].id)
            let trailingTeam = try await playerService.fetch(team: match.opponents[1].id)

            DispatchQueue.main.async {
                self.leadingPlayes = leadingTeam.players
                self.trailingPlayes = trailingTeam.players
            }
        } catch {
            print(error)
        }
    }
}
