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
            Text(match.title.wrappedValue+"\(match.id)")
        }
    }
}

#Preview {
    MatchesListView(viewModel: MatchesListViewModel())
}
