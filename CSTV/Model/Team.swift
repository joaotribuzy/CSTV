//
//  Team.swift
//  CSTV
//
//  Created by João Tribuzy on 01/09/24.
//

import Foundation

struct Team: Identifiable, Decodable {
    var id: Int
    var players: [Player]
    
    enum CodingKeys: CodingKey {
        case id
        case players
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.players = try container.decode([Player].self, forKey: .players)
        
    }
}
