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

    @ViewBuilder
    func view() -> some View {
        switch self {
        case .secondFirst:
            SecondFirstView()
        case .secondSecond:
            SecondSecondView()
        case .thirdSecond:
            ThirdSecondView()
        }
    }

    // The compiler will infer the RouteView associated type from the view() method
    // but we can also explicitly declare it if we want:
    // typealias RouteView = AnyView // This line is optional since Swift can infer it

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
