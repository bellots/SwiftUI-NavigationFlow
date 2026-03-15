//
//  TestRoutable.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 29/12/22.
//

import Foundation
import SwiftUI
import SwiftUINavigationFlow

enum TestRoute: Routable {
    case firstView
    case secondView
    case modalView
    case loadingView
    case errorView
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .firstView:
            FirstView()
        case .secondView:
            SecondView()
        case .modalView:
            ModalView()
        case .loadingView:
            LoadingView()
        case .errorView:
            ErrorView()
        }
    }

    var title: String? {
        switch self {
        case .firstView:
            return "firstView"
        case .secondView:
            return "secondView"
        case .modalView:
            return "modalView"
        case .loadingView:
            return nil
        case .errorView:
            return nil
        }
    }
}

extension TestRoute: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .firstView:
            hasher.combine("firstView")
        case .secondView:
            hasher.combine("secondView")
        case .modalView:
            hasher.combine("modalView")
        case .loadingView:
            hasher.combine("loadingView")
        case .errorView:
            hasher.combine("errorView")
        }
    }
}

extension TestRoute: Equatable {
    static func == (lhs: TestRoute, rhs: TestRoute) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
