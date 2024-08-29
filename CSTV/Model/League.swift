//
//  League.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import Foundation

struct League: Identifiable, Decodable {
    var id: Int
    var name: String
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image_url"
    }
}
