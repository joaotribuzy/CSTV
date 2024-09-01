//
//  PlayerTrailingFlag.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import SwiftUI

import SwiftUI

struct PlayerTrailingFlag: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Layout.backgroundCornerRadiuss)
                .fill(Colors.secondaryBackground)
                .frame(height: Layout.backgroundHeight)
                .padding(.trailing, Layout.backGroundTrailingPadding)
            HStack {
                VStack(alignment: .leading) {
                    Text("Nickname")
                        .font(Fonts.nickname)
                    Text("Nome do jogador")
                        .font(Fonts.playerName)
                        .foregroundStyle(Colors.secondaryFont)
                }
                .foregroundColor(.primary)
                .padding(.leading, Layout.infoLeadingPadding)
                Spacer()
            }
            HStack {
                RoundedRectangle(cornerRadius: Layout.imageCornerRadius)
                    .fill(Colors.placeholderImage)
                    .frame(width: Layout.imageDimension, height: Layout.imageDimension)
                    .padding(.leading, Layout.imageLeadingPadding)
                    .padding(.top, Layout.imageTopPadding)
                Spacer()
            }
        }
    }
}

private extension PlayerTrailingFlag {
    enum Layout {
        static var backgroundCornerRadiuss: CGFloat { 12 }
        static var backgroundHeight: CGFloat { 54 }
        static var backGroundTrailingPadding: CGFloat { -12 }
        static var imageCornerRadius: CGFloat { 8 }
        static var infoLeadingPadding: CGFloat { 76 }
        static var imageDimension: CGFloat { 50 }
        static var imageLeadingPadding: CGFloat { 12 }
        static var imageTopPadding: CGFloat { -12 }
    }
}

#Preview {
    PlayerTrailingFlag()
}
