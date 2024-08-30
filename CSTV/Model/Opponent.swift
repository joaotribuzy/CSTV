//
//  Oponent.swift
//  CSTV
//
//  Created by João Tribuzy on 29/08/24.
//

import Foundation

struct Opponent: Identifiable, Decodable {
    var id: Int
    var name: String
    var imageUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        if let imageUrlString = try? container.decode(String.self, forKey: .imageUrl) {
            self.imageUrl = URL(string: imageUrlString)
        } else {
            self.imageUrl = nil
        }
    }
}

struct OpponentWrapper: Decodable {
    let opponent: Opponent
}
