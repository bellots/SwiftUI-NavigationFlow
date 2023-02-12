//
//  SecondRouteFlow.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 30/12/22.
//

import Foundation
import SwiftUI
import SwiftUINavigationFlow

enum SecondRouteFlow: Routable {
    case secondFirst
    case secondSecond

    func view() -> AnyView {
        switch self {
        case .secondFirst:
            return AnyView(SecondFirstView())
        case .secondSecond:
            return AnyView(SecondSecondView())
        }
    }

    var title: String? {
        switch self {
        case .secondFirst:
            return "secondFirst"
        case .secondSecond:
            return "secondSecond"
        }
    }

    var color: UIColor {
        switch self {
        case .secondFirst:
            return .red
        case .secondSecond:
            return .purple
        }
    }
}
