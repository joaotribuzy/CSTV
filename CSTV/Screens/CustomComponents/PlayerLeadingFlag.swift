//
//  PlayerLeadingFlag.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import SwiftUI

struct PlayerLeadingFlag: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Layout.backgroundCornerRadiuss)
                .fill(Colors.secondaryBackground)
                .frame(height: Layout.backgroundHeight)
                .padding(.leading, Layout.backGroundLeadingPadding)
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Nickname")
                        .font(Fonts.nickname)
                    Text("Nome do jogador")
                        .font(Fonts.playerName)
                        .foregroundStyle(Colors.secondaryFont)
                }
                .foregroundColor(.primary)
                .padding(.trailing, Layout.infoLeadingPadding)
            }
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: Layout.imageCornerRadius)
                    .fill(Colors.placeholderImage)
                    .frame(width: Layout.imageDimension, height: Layout.imageDimension)
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
        static var infoLeadingPadding: CGFloat { 76 }
        static var imageDimension: CGFloat { 50 }
        static var imageTrailingPadding: CGFloat { 12 }
        static var imageTopPadding: CGFloat { -12 }
    }
}

#Preview {
    PlayerLeadingFlag()
}
