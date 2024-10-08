//
//  MatchesListView.swift
//  CSTV
//
//  Created by João Tribuzy on 28/08/24.
//

import SwiftUI

protocol MatchesListDataSourceable: ObservableObject {
    var matches: [Match] { get set }
    var isLoading: Bool { get }
    var showDownloadError: Bool { get set }
    func requestMatches() async
    func refreshMatches() async
    func requestOpponentsImages(for opponents: [Opponent]) async
    func requestLeagueImage(for league: League) async
    func requestDetailViewModel(for match: Match) -> MatchDetailViewModel
}

struct MatchesListView<ViewModel: MatchesListDataSourceable>: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if !viewModel.isLoading {
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
                    }
                    .refreshable {
                        await viewModel.refreshMatches()
                    }
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Partidas")
            .toolbarBackground(Colors.primaryBackground, for: .navigationBar)
            .background(Colors.primaryBackground)
        }
        .accentColor(.primary)
        .task(priority: .high) {
            await viewModel.requestMatches()
        }
        .alert(isPresented: $viewModel.showDownloadError) {
            Alert(
                title: Text("Que pena..."),
                message: Text("Tivemos um problema ao obter o seu conteúdo T-T"),
                dismissButton: .default(Text("Tentar novamente"), action: {
                    Task {
                        await viewModel.refreshMatches()
                    }
                })
            )
        }
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
            if let url = match.wrappedValue.league.imageDataUrl {
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
        .task {
            await viewModel.requestLeagueImage(for: match.wrappedValue.league)
        }
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
