//
//  ContentViewModel.swift
//  CSTV
//
//  Created by João Tribuzy on 02/09/24.
//

import SwiftUI

final class ContentViewModel: ContentDataSourceable {
    
    @Published var isShowingSplashScreen: Bool = true
    var matchesListViewModel: MatchesListViewModel = MatchesListViewModel(matchService: MatchService(), imageService: ImageService())
    
    func requestHideSplashScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.isShowingSplashScreen = false
            }
        }
    }
}
