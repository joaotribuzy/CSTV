//
//  Fonts.swift
//  CSTV
//
//  Created by João Tribuzy on 29/08/24.
//

import SwiftUI

enum Fonts {
    static let teamFlagTitle = customFont(size: 16)
    static let versusTitle = customFont(size: 18)
    static let leagueDescription = customFont(size: 14)
    
    private static func customFont(size: CGFloat) -> Font {
        return Font.system(size: size)
    }
}
