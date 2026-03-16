//
//  NavigationFlow.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import Foundation
import SwiftUI

@MainActor public struct NavigationFlow<T: Routable>: View {

    @ObservedObject var navigationViewModel: NavigationViewModel

    var firstRoute: T

    public init(firstRoute: T,
                navigationViewModel: NavigationViewModel) {
        self.firstRoute = firstRoute
        self.navigationViewModel = navigationViewModel
    }

    // Binding for the NavigationStack push path (only .push states)
    private var pushPath: Binding<[NavigationState]> {
        Binding(
            get: {
                navigationViewModel.states.filter { $0.presentationType == .push }
            },
            set: { newPath in
                let pushStates = navigationViewModel.states.filter { $0.presentationType == .push }
                guard newPath.count < pushStates.count else { return }
                var states = navigationViewModel.states
                let removedCount = pushStates.count - newPath.count
                for _ in 0..<removedCount {
                    if let lastPushIndex = states.lastIndex(where: { $0.presentationType == .push }) {
                        states.remove(at: lastPushIndex)
                    }
                }
                navigationViewModel.states = states
            }
        )
    }

    // Binding for the currently presented sheet (.present)
    private var sheetState: Binding<NavigationState?> {
        Binding(
            get: {
                navigationViewModel.states.last(where: { $0.presentationType == .present })
            },
            set: { newValue in
                guard newValue == nil else { return }
                if let lastIndex = navigationViewModel.states.lastIndex(where: { $0.presentationType == .present }) {
                    navigationViewModel.states.remove(at: lastIndex)
                }
            }
        )
    }

    // Binding for the currently presented full-screen cover (.presentFullScreen)
    private var fullScreenState: Binding<NavigationState?> {
        Binding(
            get: {
                navigationViewModel.states.last(where: { $0.presentationType == .presentFullScreen })
            },
            set: { newValue in
                guard newValue == nil else { return }
                if let lastIndex = navigationViewModel.states.lastIndex(where: { $0.presentationType == .presentFullScreen }) {
                    navigationViewModel.states.remove(at: lastIndex)
                }
            }
        )
    }

    public var body: some View {
        NavigationStack(path: pushPath) {
            firstRoute.view()
                .environmentObject(navigationViewModel)
                .navigationTitle(firstRoute.title ?? "")
                .navigationDestination(for: NavigationState.self) { state in
                    AnyView(state.makeView())
                        .environmentObject(navigationViewModel)
                        .navigationTitle(state.route.title ?? "")
                }
        }
        // Ensure the navigation bar background is always visible, even when the
        // root view is not scrollable (SwiftUI NavigationStack uses a transparent
        // bar by default until content scrolls behind it).
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(item: sheetState) { state in
            AnyView(state.makeView())
                .environmentObject(navigationViewModel)
        }
        .fullScreenCover(item: fullScreenState) { state in
            AnyView(state.makeView())
                .environmentObject(navigationViewModel)
        }
    }
}
