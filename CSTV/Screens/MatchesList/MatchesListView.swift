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
        NavigationView {
            ScrollView {
                VStack(spacing: Layout.contentVerticalSpacing) {
                    ForEach($viewModel.matches) { match in
                        matchCell()
                    }
                }
                .padding(.horizontal, Layout.contentHorizontalPadding)
                .task {
                    await viewModel.requestMatches()
                }
            }
            .navigationTitle("Partidas")
            .toolbarBackground(Colors.primaryBackground, for: .navigationBar)
            .background(Colors.primaryBackground)
        }
    }
    
    func matchCell() -> some View {
        VStack(spacing: .zero) {
            HStack {
                Spacer()
                timeLabel()
            }
            versusFlags()
            Divider()
                .frame(height: Layout.dividerHeight)
                .background(.white)
                .opacity(Style.cellDividerOpacity)
                .padding(.top, Layout.cellElementsSpacing)
            leagueDescription()
        }
        .background(Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: Layout.cellCornerRadius))
    }
    
    func leagueDescription() -> some View {
        HStack(alignment: .center) {
            Circle()
                .frame(width: Layout.leagueLogoDimension)
            Text("League + serie")
                .font(Fonts.leagueDescription)
            Spacer()
        }
        .padding(.vertical, Layout.leagueVerticalSpacing)
        .padding(.horizontal, Layout.leagueHorizontalSpacing)
    }
    
    func versusFlags() -> some View {
        HStack(spacing: Layout.versusInnerSpacing) {
            teamFlag()
            Text(Content.vs)
                .font(Fonts.versusTitle)
                .opacity(Style.versusOpacity)
            teamFlag()
        }
        .padding(.top, Layout.cellElementsSpacing)
    }
    
    func timeLabel() -> some View {
        ZStack {
            BottomLeftRoundedRectangle(cornerRadius: Layout.cellCornerRadius)
                .fill(Color.red)
            
            Text("AGORA")
                .font(Fonts.timeLabel)
                .padding(Layout.timeLabelPadding)
        }
        .fixedSize(horizontal: true, vertical: true)
        .frame(height: Layout.timeLabelHeight)
    }
    
    func teamFlag() -> some View {
        VStack(spacing: Layout.teamFlagInnerSpacing) {
            Circle()
                .frame(width: Layout.opponentImageDimension)
                .foregroundStyle(Colors.placeholderImage)
            Text("Team")
                .font(Fonts.teamFlagTitle)
        }
    }
}

private extension MatchesListView {
    enum Layout {
        static var cellCornerRadius: CGFloat { 16 }
        static var contentHorizontalPadding: CGFloat { 24 }
        static var contentVerticalSpacing: CGFloat { 24 }
        static var opponentImageDimension: CGFloat { 60 }
        static var teamFlagInnerSpacing: CGFloat { 10 }
        static var cellElementsSpacing: CGFloat { 18.5 }
        static var versusInnerSpacing: CGFloat { 20 }
        static var leagueLogoDimension: CGFloat { 16 }
        static var dividerHeight: CGFloat { 1 }
        static var leagueVerticalSpacing: CGFloat { 8 }
        static var leagueHorizontalSpacing: CGFloat { 15 }
        static var timeLabelHeight: CGFloat { 25 }
        static var timeLabelPadding: CGFloat { 8 }
    }
    
    enum Style {
        static var versusOpacity: CGFloat { 0.5 }
        static var cellDividerOpacity: CGFloat { 0.2 }
    }
    
    enum Content {
        static var vs: String { "VS" }
    }
}

#Preview {
    MatchesListView(viewModel: MatchesListViewModel(matchService: MatchService(networkManager: NetworkManager(urlSession: URLSession.shared))))
}
