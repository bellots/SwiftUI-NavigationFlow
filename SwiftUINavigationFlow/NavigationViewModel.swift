//
//  NavigationViewModel.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import Foundation

public class NavigationViewModel: ObservableObject {
    /// Duration to wait after a dismiss before running a completion callback,
    /// matching the default SwiftUI modal dismiss animation.
    public static let dismissAnimationDuration: TimeInterval = 0.5

    public var parentNavigationViewModel: NavigationViewModel?

    @Published public var states: [NavigationState] = []

    public func dismissCurrent(forced: Bool = false, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if !self.states.isEmpty {
                self.states.removeLast()
            }
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + NavigationViewModel.dismissAnimationDuration) {
                    completion()
                }
            }
        }
    }

    public func present(state: NavigationState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.states.append(state)
        }
    }

    public init(parentNavigationViewModel: NavigationViewModel? = nil) {
        self.parentNavigationViewModel = parentNavigationViewModel
    }
}
