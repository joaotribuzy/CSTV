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
    var fullName: String
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
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        
        let firstName = try container.decode(String?.self, forKey: .firstName) ?? ""
        let lastName = try container.decode(String?.self, forKey: .lastName) ?? ""
        
        self.fullName = "\(firstName) \(lastName)"
        
        if let imageUrlString = try? container.decode(String.self, forKey: .imageUrl) {
            self.imageUrl = URL(string: imageUrlString)
        } else {
            self.imageUrl = nil
        }
    }
}
