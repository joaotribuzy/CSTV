//
//  MatchDetailView.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import SwiftUI

protocol MatchDetailDataSourceable: ObservableObject {
    var match: Match { get }
}

struct MatchDetailView<ViewModel: MatchDetailDataSourceable>: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.match.name)
    }
    
}
