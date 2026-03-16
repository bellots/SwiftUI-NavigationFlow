//
//  ExploreRoute.swift
//  TestRouterNavigation
//

import SwiftUI
import SwiftUINavigationFlow

enum ExploreRoute: Routable {
    case explore
    case exploreDetail

    @ViewBuilder
    func view() -> some View {
        switch self {
        case .explore:
            ExploreView()
        case .exploreDetail:
            ExploreDetailView()
        }
    }

    var title: String? {
        switch self {
        case .explore:
            return "Explore"
        case .exploreDetail:
            return "Category Results"
        }
    }
}
