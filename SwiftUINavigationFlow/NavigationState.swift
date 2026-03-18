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
    /// Captured at init time while the concrete `Routable` type `R` is still
    /// known, so the resulting `AnyView` wraps the real view type rather than
    /// an opaque existential.
    private let _viewFactory: (NavigationViewModel) -> AnyView

    public init<R: Routable>(id: UUID = UUID(), route: R, presentationType: PresentationType) {
        self.id = id
        self.route = route
        self.presentationType = presentationType
        self._viewFactory = { navigationViewModel in
            AnyView(route.view().environmentObject(navigationViewModel))
        }
    }

    func makeView(navigationViewModel: NavigationViewModel) -> AnyView {
        _viewFactory(navigationViewModel)
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
