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

    // The compiler will infer the RouteView associated type from the view() method
    // It will be a concrete type representing the entire view hierarchy
    // We don't need to specify it explicitly as Swift can infer it

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

    var color: UIColor {
        switch self {
        case .firstView:
            return .black
        case .secondView:
            return .red
        case .modalView:
            return .systemPink
        case .loadingView:
            return .black
        case .errorView:
            return .black
        }
    }
    
    var showNavigationBar: Bool {
        return true
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
