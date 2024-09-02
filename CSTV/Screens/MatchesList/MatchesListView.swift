//
//  MatchesListView.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import SwiftUI

protocol MatchesListDataSourceable: ObservableObject {
    var matches: [Match] { get set }
    func requestRunningMatches() async
    func requestUpcomingMatches() async
    func requestOpponentsImages(for opponents: [Opponent]) async
    func requestDetailViewModel(for match: Match) -> MatchDetailViewModel
}

struct MatchesListView<ViewModel: MatchesListDataSourceable>: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: Layout.contentVerticalSpacing) {
                    ForEach($viewModel.matches) { match in
                        NavigationLink(
                            destination: MatchDetailView(
                                viewModel: viewModel.requestDetailViewModel(for: match.wrappedValue)
                            )
                        ) {
                            matchCell(match: match)
                        }
                    }
                }
                .padding(.horizontal, Layout.contentHorizontalPadding)
                .task(priority: .high) {
                    await viewModel.requestRunningMatches()
                }
                .task {
                    await viewModel.requestUpcomingMatches()
                }
            }
            .navigationTitle("Partidas")
            .toolbarBackground(Colors.primaryBackground, for: .navigationBar)
            .background(Colors.primaryBackground)
        }
        .accentColor(.primary)
    }
    
    func matchCell(match: Binding<Match>) -> some View {
        VStack(spacing: .zero) {
            HStack {
                Spacer()
                timeLabel(match.wrappedValue)
            }
            VersusFlags(opponents: match.opponents.wrappedValue)
                .padding(.top, Layout.cellElementsSpacing)
                .task {
                    await viewModel.requestOpponentsImages(for: match.opponents.wrappedValue)
                }
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
    
    func timeLabel(_ match: Match) -> some View {
        ZStack {
            BottomLeftRoundedRectangle(cornerRadius: Layout.cellCornerRadius)
                .fill(match.isRunning() ? Colors.matchRunning : Colors.upcomingMatch)
                .opacity(
                    match.isRunning() ? Style.runningMatchTimeLabel : Style.upcomingMatchTimeLabel
                )
            Text(match.timeDescription)
                .font(Fonts.timeLabel)
                .padding(Layout.timeLabelPadding)
        }
        .fixedSize(horizontal: true, vertical: true)
        .frame(height: Layout.timeLabelHeight)
    }
    
    func leagueDescription(_ match: Binding<Match>) -> some View {
        HStack(spacing: Layout.leagueHStackSpacing) {
            if let url = match.wrappedValue.league.imageUrl {
                AsyncImage(url: url, transaction: .init(animation: .easeInOut)) { phase in
                    if case .success(let image) = phase {
                        image
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(height: Layout.leagueLogoDimension)
            }
            Text(match.wrappedValue.leagueSerieDescription)
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
        static var cellElementsSpacing: CGFloat { 18.5 }
        static var leagueLogoDimension: CGFloat { 16 }
        static var dividerHeight: CGFloat { 1 }
        static var leagueVerticalSpacing: CGFloat { 8 }
        static var leagueHorizontalSpacing: CGFloat { 15 }
        static var timeLabelHeight: CGFloat { 25 }
        static var timeLabelPadding: CGFloat { 8 }
        static var leagueHStackSpacing: CGFloat { 8 }
    }
    
    enum Style {
        static var cellDividerOpacity: CGFloat { 0.2 }
        static var runningMatchTimeLabel: CGFloat { 1 }
        static var upcomingMatchTimeLabel: CGFloat { 0.2 }
    }
}

#Preview {
    MatchesListView(viewModel: MatchesListViewModel(matchService: MatchService(), imageService: ImageService()))
}
