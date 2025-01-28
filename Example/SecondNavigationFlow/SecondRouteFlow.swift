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
    case thirdSecond

    func view() -> AnyView {
        switch self {
        case .secondFirst:
            return AnyView(SecondFirstView())
        case .secondSecond:
            return AnyView(SecondSecondView())
        case .thirdSecond:
            return AnyView(ThirdSecondView())
        }
    }

    var title: String? {
        switch self {
        case .secondFirst:
            return "secondFirst"
        case .secondSecond:
            return "secondSecond"
        case .thirdSecond:
            return "thirdSecond"
        }
    }

    var color: UIColor {
        switch self {
        case .secondFirst:
            return .red
        case .secondSecond:
            return .purple
        case .thirdSecond:
            return .blue
        }
    }
    
    var showNavigationBar: Bool {
        switch self {
        case .secondFirst:
            return false
        case .secondSecond:
            return true
        case .thirdSecond:
            return true
        }
    }
}
