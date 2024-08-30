//
//  MatchesListView.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import SwiftUI

protocol MatchesListDataSourceable: ObservableObject {
    var matches: [Match] { get set }
    func requestMatches() async
}

struct MatchesListView<ViewModel: MatchesListDataSourceable>: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        List($viewModel.matches) { match in
            VStack(alignment: .leading) {
                Text(match.name.wrappedValue)
                Text(match.league.name.wrappedValue)
            }
        }
        .task {
            await viewModel.requestMatches()
        }
    }
}

#Preview {
    MatchesListView(viewModel: MatchesListViewModel(matchService: MatchService(networkManager: NetworkManager(urlSession: URLSession.shared))))
}
