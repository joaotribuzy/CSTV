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
    var imageStringUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageStringUrl = "image_url"
    }
}

struct OpponentWrapper: Decodable {
    let opponent: Opponent
}
