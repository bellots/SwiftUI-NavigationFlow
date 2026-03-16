//
//  HomeView.swift
//  TestRouterNavigation
//

import SwiftUI
import SwiftUINavigationFlow

struct HomeView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel

    private let articles = ["SwiftUI Basics", "Combine Framework", "NavigationStack Deep Dive"]

    var body: some View {
        List(articles, id: \.self) { article in
            Button {
                navigationViewModel.states.append(
                    NavigationState(route: HomeRoute.homeDetail, presentationType: .push)
                )
            } label: {
                HStack {
                    Image(systemName: "doc.text")
                        .foregroundColor(.blue)
                    Text(article)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}
