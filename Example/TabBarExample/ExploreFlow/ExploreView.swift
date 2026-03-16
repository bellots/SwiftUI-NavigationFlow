//
//  ExploreView.swift
//  TestRouterNavigation
//

import SwiftUI
import SwiftUINavigationFlow

struct ExploreView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel

    private let categories = [
        ("Technology", "laptopcomputer"),
        ("Science", "atom"),
        ("Design", "paintpalette"),
    ]

    var body: some View {
        List(categories, id: \.0) { category, icon in
            Button {
                navigationViewModel.states.append(
                    NavigationState(route: ExploreRoute.exploreDetail, presentationType: .push)
                )
            } label: {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(.orange)
                    Text(category)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}
