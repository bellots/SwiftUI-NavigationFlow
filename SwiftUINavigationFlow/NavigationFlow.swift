//
//  NavigationFlow.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import SwiftUI

@MainActor public struct NavigationFlow<T: Routable>: View {

    @ObservedObject var navigationViewModel: NavigationViewModel

    var firstRoute: T

    public init(firstRoute: T,
                navigationViewModel: NavigationViewModel) {
        self.firstRoute = firstRoute
        self.navigationViewModel = navigationViewModel
    }

    // Binding for the NavigationStack path (push states only).
    // When NavigationStack updates the path (e.g. the user swipes back), the
    // setter reconciles the full states array by removing any push states that
    // are no longer present in the path.
    private var pushPath: Binding<[NavigationState]> {
        Binding(
            get: {
                navigationViewModel.states.filter { $0.presentationType == .push }
            },
            set: { newPushStates in
                let newPushIDs = Set(newPushStates.map { $0.id })
                navigationViewModel.states = navigationViewModel.states.filter { state in
                    state.presentationType != .push || newPushIDs.contains(state.id)
                }
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
                    state.makeView()
                        .environmentObject(navigationViewModel)
                        .navigationTitle(state.route.title ?? "")
                }
                .sheet(item: sheetState) { state in
                    state.makeView()
                        .environmentObject(navigationViewModel)
                }
                .fullScreenCover(item: fullScreenState) { state in
                    state.makeView()
                        .environmentObject(navigationViewModel)
                }
        }
    }
}
