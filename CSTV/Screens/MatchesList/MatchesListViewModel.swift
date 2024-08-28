//
//  MatchesListViewModel.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

final class MatchesListViewModel: MatchesListDataSourceable {
    
    var matches: [Match] = [
        Match(id: 0, title: "Match"),
        Match(id: 1, title: "Match"),
        Match(id: 2, title: "Match"),
        Match(id: 3, title: "Match"),
        Match(id: 4, title: "Match"),
        Match(id: 5, title: "Match"),
    ]
    
    init() {}
    
    func requestMatches() async {
        
    }
}
