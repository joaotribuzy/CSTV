//
//  Match.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

struct Match: Identifiable, Decodable {
    var id: Int
    var name: String
    var league: League
    var status: Status
    var serie: Serie
    var opponents: [Opponent]
    
    enum CodingKeys: String, CodingKey {
        case id, name, league, status, serie, opponents
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.league = try container.decode(League.self, forKey: .league)
        self.status = try container.decode(Status.self, forKey: .status)
        self.serie = try container.decode(Serie.self, forKey: .serie)
        self.opponents = try container.decode([OpponentWrapper].self, forKey: .opponents).map({ opponentWrapper in
            return opponentWrapper.opponent
        })
    }
}
