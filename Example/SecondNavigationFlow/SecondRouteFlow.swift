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
}
