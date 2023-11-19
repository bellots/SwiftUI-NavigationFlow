//
//  NavigationViewModel.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import Foundation

public class NavigationViewModel: ObservableObject {
    var oldPresentationType: PresentationType?
    var hasForcedDismiss: Bool = false
    public var parentNavigationViewModel: NavigationViewModel?

    @Published public var states: [NavigationState] {
        willSet (newValue) {
            if states.isEmpty && newValue.isEmpty {
                return
            }
            if states.count > newValue.count {
                // vuol dire che sta facendo pop/dismiss
                oldPresentationType = states.last?.presentationType
            }
            else {
                oldPresentationType = nil
            }

        }
    }

    public func dismissCurrent(forced: Bool) {
        hasForcedDismiss = forced
        if !states.isEmpty {
            states.removeLast()
        }
    }


    public init(parentNavigationViewModel: NavigationViewModel?) {
        self.states = []
        self.parentNavigationViewModel = parentNavigationViewModel
    }
}
