//
//  SplashScreen.swift
//  CSTV
//
//  Created by João Tribuzy on 02/09/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Colors.primaryBackground
            Images.fuzeLogo
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashScreen()
}
