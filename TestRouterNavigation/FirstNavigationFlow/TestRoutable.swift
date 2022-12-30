//
//  TestRoutable.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 29/12/22.
//

import Foundation
import SwiftUI

enum TestRoute: Routable {
    case firstView
    case secondView
    case modalView

    func view() -> AnyView {
        switch self {
        case .firstView:
            return AnyView(FirstView())
        case .secondView:
            return AnyView(SecondView())
        case .modalView:
            return AnyView(ModalView())
        }
    }

    var title: String {
        switch self {
        case .firstView:
            return "firstView"
        case .secondView:
            return "secondView"
        case .modalView:
            return "modalView"
        }
    }
}
