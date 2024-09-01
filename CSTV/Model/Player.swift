//
//  Player.swift
//  CSTV
//
//  Created by João Tribuzy on 01/09/24.
//

import Foundation

struct Player: Identifiable, Decodable {
    var id: Int
    var isActive: Bool
    var firstName: String
    var lastName: String
    var nickname: String
    var imageUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case isActive = "active"
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname = "name"
        case imageUrl = "image_url"
    }
}
