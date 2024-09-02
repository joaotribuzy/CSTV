//
//  CSTVApp.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import SwiftUI

@main
struct CSTVApp: App {
    
    private let matchService: MatchServicing = MatchService()
    
    var body: some Scene {
        WindowGroup {
            MatchesListView(viewModel: MatchesListViewModel(matchService: matchService))
        }
    }
}
