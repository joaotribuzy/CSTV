//
//  String+Extensions.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
        guard let first = self.first else { return self }
        return first.uppercased() + self.dropFirst()
    }
}
