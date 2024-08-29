//
//  Status.swift
//  CSTV
//
//  Created by João Tribuzy on 29/08/24.
//

import Foundation

enum Status: String, Decodable {
    case running, finished, canceled
    case notStarted = "not_started"
}
