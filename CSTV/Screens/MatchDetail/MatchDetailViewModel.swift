//
//  MatchDetailViewModel.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import Foundation

final class MatchDetailViewModel: MatchDetailDataSourceable {
    var match: Match
    
    init(match: Match) {
        self.match = match
    }
}
