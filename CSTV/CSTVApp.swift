//
//  CSTVApp.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import SwiftUI

@main
struct CSTVApp: App {
    var body: some Scene {
        WindowGroup {
            MatchesListView(viewModel: MatchesListViewModel())
        }
    }
}
