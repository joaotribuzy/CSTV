//
//  ContentView.swift
//  CSTV
//
//  Created by João Tribuzy on 02/09/24.
//

import SwiftUI

protocol ContentDataSourceable: ObservableObject {
    var isShowingSplashScreen: Bool { get }
    var matchesListViewModel: MatchesListViewModel { get }
    func requestHideSplashScreen()
}

struct ContentView<ViewModel: ContentDataSourceable>: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        if viewModel.isShowingSplashScreen {
            SplashScreen()
                .onAppear{
                    viewModel.requestHideSplashScreen()
                }
        } else {
            MatchesListView(viewModel: viewModel.matchesListViewModel)
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
