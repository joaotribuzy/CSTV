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
    private let imageService: ImageService
    
    init(matchService: MatchServicing, imageService: ImageService) {
        self.matchService = matchService
        self.imageService = imageService
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
    
    func requestOpponentsImages(for opponents: [Opponent]) async {
        do {
            
            guard let matchIndex = self.matches.firstIndex(where: { match in
                return match.opponents.contains(opponents)
            }) else { return }
            
            for opponent in opponents {
                
                guard let opponentIndex = self.matches[matchIndex].opponents.firstIndex(where: { team in
                    return opponent.id == team.id
                }) else { return }
                        
                guard let url = opponent.imageUrl?.getThumbUrl() else { return }
                
                let dataURL = try await imageService.fetchDataImageURL(from: url)
                
                DispatchQueue.main.async {
                    self.matches[matchIndex].opponents[opponentIndex].imageDataUrl = dataURL
                }
            }

        } catch {
            print(error)
        }
    }
    
    func requestLeagueImage(for league: League) async {
        do {
            guard let matchIndex = self.matches.firstIndex(where: { match in
                return match.league.id == league.id
            }) else { return }
                    
            guard let url = league.imageUrl?.getThumbUrl() else { return }
            
            let dataUrl = try await imageService.fetchDataImageURL(from: url)
            
            DispatchQueue.main.async {
                self.matches[matchIndex].league.imageDataUrl = dataUrl
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
