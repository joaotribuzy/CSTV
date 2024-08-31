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
    func requestLeagueSerieDescription(for match: Match) -> String
    func requestLeagueURL(for match: Match) -> URL?
}

struct MatchesListView<ViewModel: MatchesListDataSourceable>: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Layout.contentVerticalSpacing) {
                    ForEach($viewModel.matches) { match in
                        matchCell(match: match)
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
    
    func matchCell(match: Binding<Match>) -> some View {
        VStack(spacing: .zero) {
            HStack {
                Spacer()
                timeLabel()
            }
            versusFlags(opponents: match.opponents)
            Divider()
                .frame(height: Layout.dividerHeight)
                .background(.white)
                .opacity(Style.cellDividerOpacity)
                .padding(.top, Layout.cellElementsSpacing)
            leagueDescription(match)
        }
        .background(Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: Layout.cellCornerRadius))
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
    
    func versusFlags(opponents: Binding<[Opponent]>) -> some View {
        HStack(spacing: Layout.versusInnerSpacing) {
            switch opponents.count {
            case 1:
                teamFlag(opponent: opponents[0])
            case 2:
                teamFlag(opponent: opponents[0])
                Text(Content.vs)
                    .font(Fonts.versusTitle)
                    .opacity(Style.versusOpacity)
                teamFlag(opponent: opponents[1])
            default:
                Spacer()
            }
        }
        .padding(.top, Layout.cellElementsSpacing)
    }
    
    func teamFlag(opponent: Binding<Opponent>) -> some View {
        VStack(spacing: Layout.teamFlagInnerSpacing) {
            Group {
                if let url = opponent.wrappedValue.imageUrl {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        default:
                            Circle()
                        }
                    }
                } else {
                    Circle()
                }
            }
            .frame(
                width: Layout.opponentElementDimension,
                height: Layout.opponentElementDimension
            )
            .foregroundStyle(Colors.placeholderImage)
            Text(opponent.wrappedValue.name)
                .font(Fonts.teamFlagTitle)
        }
    }
    
    func leagueDescription(_ match: Binding<Match>) -> some View {
        HStack(spacing: Layout.leagueHStackSpacing) {
            if let url = viewModel.requestLeagueURL(for: match.wrappedValue) {
                AsyncImage(url: url) { phase in
                    if case .success(let image) = phase {
                        image
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(height: Layout.leagueLogoDimension)
            }
            Text(
                viewModel.requestLeagueSerieDescription(for: match.wrappedValue)
            )
            .font(Fonts.leagueDescription)
            Spacer()
        }
        .padding(.vertical, Layout.leagueVerticalSpacing)
        .padding(.horizontal, Layout.leagueHorizontalSpacing)
    }
    
}

private extension MatchesListView {
    enum Layout {
        static var cellCornerRadius: CGFloat { 16 }
        static var contentHorizontalPadding: CGFloat { 24 }
        static var contentVerticalSpacing: CGFloat { 24 }
        static var opponentElementDimension: CGFloat { 60 }
        static var teamFlagInnerSpacing: CGFloat { 10 }
        static var cellElementsSpacing: CGFloat { 18.5 }
        static var versusInnerSpacing: CGFloat { 20 }
        static var leagueLogoDimension: CGFloat { 16 }
        static var dividerHeight: CGFloat { 1 }
        static var leagueVerticalSpacing: CGFloat { 8 }
        static var leagueHorizontalSpacing: CGFloat { 15 }
        static var timeLabelHeight: CGFloat { 25 }
        static var timeLabelPadding: CGFloat { 8 }
        static var leagueHStackSpacing: CGFloat { 8 }
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
