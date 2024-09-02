//
//  CSTVApp.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import SwiftUI

@main
struct CSTVApp: App {
    
    private let contentViewModel: ContentViewModel = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: contentViewModel)
        }
    }
}
