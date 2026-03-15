//
//  NavigationState.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import Foundation
import SwiftUI

public enum PresentationType {
    case push
    case present
    case presentFullScreen
}

public struct NavigationState: Identifiable {
    public var id: UUID
    public var route: any Routable
    var presentationType: PresentationType
    private let viewFactory: () -> AnyView

    public init<R: Routable>(id: UUID = UUID(), route: R, presentationType: PresentationType) {
        self.id = id
        self.route = route
        self.presentationType = presentationType
        self.viewFactory = { AnyView(route.view()) }
    }

    func makeView() -> AnyView {
        viewFactory()
    }
}

extension NavigationState: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension NavigationState: Equatable {
    public static func == (lhs: NavigationState, rhs: NavigationState) -> Bool {
        return lhs.id == rhs.id
    }
}
