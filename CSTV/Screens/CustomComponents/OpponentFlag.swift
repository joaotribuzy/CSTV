//
//  OpponentFlag.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import SwiftUI

struct OpponentFlag: View {
    
    private(set) var opponent: Opponent
    
    var body: some View {
        VStack(spacing: Layout.teamFlagInnerSpacing) {
            Group {
                if let url = opponent.imageDataUrl {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        default:
                            Circle()
                        }
                    }
                } else {
                    Circle()
                }
            }
            .frame(
                width: Layout.opponentElementDimension,
                height: Layout.opponentElementDimension
            )
            .foregroundStyle(Colors.placeholderImage)
            Text(opponent.name)
                .font(Fonts.teamFlagTitle)
        }
    }
}

private extension OpponentFlag {
    enum Layout {
        static var opponentElementDimension: CGFloat { 60 }
        static var teamFlagInnerSpacing: CGFloat { 10 }
    }
}
