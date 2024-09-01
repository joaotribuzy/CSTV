//
//  MatchDetailView.swift
//  CSTV
//
//  Created by João Tribuzy on 31/08/24.
//

import SwiftUI

protocol MatchDetailDataSourceable: ObservableObject {
    var match: Match { get }
    func requestTeamData() async
}

struct MatchDetailView<ViewModel: MatchDetailDataSourceable>: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: .zero) {
            customNavigationBar
            ScrollView {
                VStack {
                    VersusFlags(opponents: viewModel.match.opponents)
                        .padding(.top, Layout.innerVerticalSpacing)
                    
                    Text(viewModel.match.timeDescription)
                        .font(Fonts.detailViewTime)
                        .padding(.top, Layout.innerVerticalSpacing)
                    
                    HStack(spacing: Layout.playerGridSpacing) {
                        VStack(spacing: Layout.playerGridSpacing) {
                            PlayerLeadingFlag()
                            PlayerLeadingFlag()
                            PlayerLeadingFlag()
                            PlayerLeadingFlag()
                            PlayerLeadingFlag()
                        }
                        VStack(spacing: Layout.playerGridSpacing) {
                            PlayerTrailingFlag()
                            PlayerTrailingFlag()
                            PlayerTrailingFlag()
                            PlayerTrailingFlag()
                            PlayerTrailingFlag()
                        }
                    }
                    .padding(.top, Layout.innerVerticalSpacing)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar(.hidden)
        }
        .background(Colors.primaryBackground)
    }
    
    var customNavigationBar: some View {
        ZStack(alignment: .top) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Images.arrowBackwards
                }
                .frame(
                    width: Layout.backButtonDimension,
                    height: Layout.backButtonDimension
                )
                .padding(.leading, Layout.backButtonLeadingPadding)
                
                Spacer()
            }
            
            Text(viewModel.match.leagueSerieDescription)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .font(Fonts.detailViewTitle)
                .padding(.horizontal, Layout.navigationTitleHorizontalPadding)
            
        }
    }
    
}

private extension MatchDetailView {
    enum Layout {
        static var backButtonDimension: CGFloat { 24 }
        static var backButtonLeadingPadding: CGFloat { 24 }
        static var navigationTitleHorizontalPadding: CGFloat { 48 }
        static var innerVerticalSpacing: CGFloat { 24 }
        static var playerGridSpacing: CGFloat { 12 }
    }
}
