//
//  VersusFlags.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import SwiftUI

struct VersusFlags: View {
    
    private(set) var opponents: [Opponent]
    
    var body: some View {
        HStack(spacing: Layout.versusInnerSpacing) {
            switch opponents.count {
            case 1:
                OpponentFlag(opponent: opponents[0])
            case 2:
                OpponentFlag(opponent: opponents[0])
                Text(Content.vs)
                    .font(Fonts.versusTitle)
                    .opacity(Style.versusOpacity)
                OpponentFlag(opponent: opponents[1])
            default:
                Spacer()
            }
        }
    }
}

private extension VersusFlags {
    
    enum Layout {
        static var versusInnerSpacing: CGFloat { 20 }
    }
    
    enum Style {
        static var versusOpacity: CGFloat { 0.5 }
    }
    
    enum Content {
        static var vs: String { "VS" }
    }
}
