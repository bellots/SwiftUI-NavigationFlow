//
//  NavigationState.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import Foundation
import SwiftUI
import UIKit

public enum PresentationType {
    case push
    case present
    case presentFullScreen
}

public struct NavigationState: Identifiable {
    public var id: UUID
    public var route: any Routable
    var presentationType: PresentationType
    // Stores the type-erased SwiftUI view once at init time (used for sheets /
    // full-screen covers that are presented via SwiftUI modifiers).
    private let _view: AnyView

    // Factory that creates a UIHostingController with the concrete RouteView type
    // so Xcode's view-hierarchy / 3D debugger shows a named entry per screen.
    private let hostingControllerFactory: (NavigationViewModel) -> UIViewController

    public init<R: Routable>(id: UUID = UUID(), route: R, presentationType: PresentationType) {
        self.id = id
        self.route = route
        self.presentationType = presentationType
        self._view = AnyView(route.view())
        self.hostingControllerFactory = { navigationViewModel in
            let vc = UIHostingController(
                rootView: route.view()
                    .environmentObject(navigationViewModel)
            )
            vc.title = route.title
            return vc
        }
    }

    func makeView() -> AnyView {
        _view
    }

    func makeHostingController(navigationViewModel: NavigationViewModel) -> UIViewController {
        hostingControllerFactory(navigationViewModel)
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
