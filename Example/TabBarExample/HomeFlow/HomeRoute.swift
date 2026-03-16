//
//  HomeRoute.swift
//  TestRouterNavigation
//

import SwiftUI
import SwiftUINavigationFlow

enum HomeRoute: Routable {
    case home
    case homeDetail

    @ViewBuilder
    func view() -> some View {
        switch self {
        case .home:
            HomeView()
        case .homeDetail:
            HomeDetailView()
        }
    }

    var title: String? {
        switch self {
        case .home:
            return "Home"
        case .homeDetail:
            return "Article Detail"
        }
    }
}
