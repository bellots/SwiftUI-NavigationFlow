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
    
    func view() -> AnyView {
        switch self {
        case .firstView:
            return AnyView(FirstView())
        case .secondView:
            return AnyView(SecondView())
        case .modalView:
            return AnyView(ModalView())
        case .loadingView:
            return AnyView(LoadingView())
        case .errorView:
            return AnyView(ErrorView())
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
