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
    var opponents: [OpponentWrapper]
}
