//
//  Fonts.swift
//  CSTV
//
//  Created by João Tribuzy on 29/08/24.
//

import SwiftUI

enum Fonts {
    static let teamFlagTitle = customFont(size: 12)
    static let versusTitle = customFont(size: 14)
    static let leagueDescription = customFont(size: 10)
    static let timeLabel = customFont(size: 10, weight: .bold)
    static let detailViewTitle = customFont(size: 18, weight: .medium)
    static let nickname = customFont(size: 14, weight: .bold)
    static let playerName = customFont(size: 12)
    
    private static func customFont(size: CGFloat, weight: Font.Weight? = nil) -> Font {
        switch weight {
            case .medium:
                return Font.custom("Roboto-Medium", size: size)
            case .bold:
                return Font.custom("Roboto-Bold", size: size)
            default:
                return Font.custom("Roboto-Regular", size: size)
        }
    }
}
