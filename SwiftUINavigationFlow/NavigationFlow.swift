//
//  NavigationFlow.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import SwiftUI

/// A custom navigation container that drives push navigation with SwiftUI slide
/// transitions and modals with native sheet / full-screen-cover presentation,
/// without relying on `UINavigationController` or `NavigationStack`.
///
/// Every destination lives in the same SwiftUI `ZStack`, so the Xcode 3D view
/// debugger shows all screens as real view nodes in the tree rather than opaque
/// `UIHostingController` wrappers.
@MainActor public struct NavigationFlow<T: Routable>: View {

    @ObservedObject var navigationViewModel: NavigationViewModel
    var firstRoute: T

    public init(firstRoute: T,
                navigationViewModel: NavigationViewModel) {
        self.firstRoute = firstRoute
        self.navigationViewModel = navigationViewModel
    }

    // MARK: - Constants

    /// Duration of the push/pop slide animation.
    private let pushAnimationDuration: TimeInterval = 0.35
    /// Maximum X position of a touch that counts as starting from the left edge.
    private let edgeDetectionWidth: CGFloat = 25
    /// Minimum horizontal swipe distance required to trigger a pop.
    private let minimumSwipeDistance: CGFloat = 80

    // MARK: - Derived state

    private var pushStates: [NavigationState] {
        navigationViewModel.states.filter { $0.presentationType == .push }
    }

    private var presentState: NavigationState? {
        navigationViewModel.states.last { $0.presentationType == .present }
    }

    private var fullScreenState: NavigationState? {
        navigationViewModel.states.last { $0.presentationType == .presentFullScreen }
    }

    // MARK: - Body

    public var body: some View {
        ZStack {
            // Root screen – always visible at the bottom of the stack.
            firstRoute.view()
                .environmentObject(navigationViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Pushed screens – each slides in from the trailing edge.
            ForEach(pushStates) { state in
                state.makeView(navigationViewModel: navigationViewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut(duration: pushAnimationDuration), value: pushStates.count)
        // Left-edge swipe to pop the top pushed screen, mirroring the
        // UINavigationController interactive-pop gesture.
        .simultaneousGesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .global)
                .onEnded { value in
                    guard !pushStates.isEmpty,
                          value.startLocation.x < edgeDetectionWidth,
                          value.translation.width > minimumSwipeDistance,
                          abs(value.translation.height) < abs(value.translation.width)
                    else { return }
                    navigationViewModel.dismissCurrent()
                }
        )
        // Sheet modal
        .sheet(
            item: Binding(
                get: { presentState },
                set: { newValue in
                    if newValue == nil { removePresentState() }
                }
            )
        ) { state in
            state.makeView(navigationViewModel: navigationViewModel)
        }
        // Full-screen modal
        .fullScreenCover(
            item: Binding(
                get: { fullScreenState },
                set: { newValue in
                    if newValue == nil { removeFullScreenState() }
                }
            )
        ) { state in
            state.makeView(navigationViewModel: navigationViewModel)
        }
    }

    // MARK: - Modal dismiss helpers

    private func removePresentState() {
        if let idx = navigationViewModel.states.lastIndex(where: {
            $0.presentationType == .present
        }) {
            navigationViewModel.states.remove(at: idx)
        }
    }

    private func removeFullScreenState() {
        if let idx = navigationViewModel.states.lastIndex(where: {
            $0.presentationType == .presentFullScreen
        }) {
            navigationViewModel.states.remove(at: idx)
        }
    }
}
