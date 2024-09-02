//
//  PlayerLeadingFlag.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import SwiftUI

struct PlayerLeadingFlag: View {
    
    private(set) var player: Player
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Layout.backgroundCornerRadiuss)
                .fill(Colors.secondaryBackground)
                .frame(height: Layout.backgroundHeight)
                .padding(.leading, Layout.backGroundLeadingPadding)
            HStack(alignment: .top) {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(player.nickname)
                        .font(Fonts.nickname)
                        .lineLimit(1)
                    Text(player.fullName)
                        .font(Fonts.playerName)
                        .foregroundStyle(Colors.secondaryFont)
                        .lineLimit(1)
                }
                .foregroundColor(.primary)
                .padding(.trailing, Layout.infoTrailingPadding)
            }
            HStack {
                Spacer()
                AsyncImage(url: player.imageUrl?.getThumbUrl()) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Colors.placeholderImage
                }
                .frame(width: Layout.imageDimension, height: Layout.imageDimension)
                .clipShape(RoundedRectangle(cornerRadius: Layout.imageCornerRadius))
                .padding(.trailing, Layout.imageTrailingPadding)
                .padding(.top, Layout.imageTopPadding)
            }
        }
    }
}

private extension PlayerLeadingFlag {
    enum Layout {
        static var backgroundCornerRadiuss: CGFloat { 12 }
        static var backgroundHeight: CGFloat { 54 }
        static var backGroundLeadingPadding: CGFloat { -12 }
        static var imageCornerRadius: CGFloat { 8 }
        static var infoTrailingPadding: CGFloat { 76 }
        static var imageDimension: CGFloat { 50 }
        static var imageTrailingPadding: CGFloat { 12 }
        static var imageTopPadding: CGFloat { -12 }
    }
}
