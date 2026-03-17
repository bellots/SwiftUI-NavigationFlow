//
//  NavigationFlow.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import SwiftUI
import UIKit
import Combine

/// A navigation container that wraps a `UINavigationController` so that every
/// pushed destination lives in its own `UIHostingController`.  This keeps the
/// Xcode view-debugger hierarchy flat and readable: you see the real screen type
/// (`HomeView`, `ExploreView`, …) directly instead of layers of `ModifiedContent`.
@MainActor public struct NavigationFlow<T: Routable>: UIViewControllerRepresentable {

    @ObservedObject var navigationViewModel: NavigationViewModel
    var firstRoute: T

    public init(firstRoute: T,
                navigationViewModel: NavigationViewModel) {
        self.firstRoute = firstRoute
        self.navigationViewModel = navigationViewModel
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(firstRoute: firstRoute, navigationViewModel: navigationViewModel)
    }

    public func makeUIViewController(context: Context) -> UINavigationController {
        context.coordinator.setUp()
    }

    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}

    // MARK: - Coordinator

    public final class Coordinator: NSObject, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {

        private let firstRoute: T
        let navigationViewModel: NavigationViewModel

        private var cancellables = Set<AnyCancellable>()
        private weak var navigationController: UINavigationController?
        /// ID of the modal state that is currently presented, used to avoid
        /// re-presenting or re-dismissing when nothing actually changed.
        private var presentedModalStateID: UUID?

        init(firstRoute: T, navigationViewModel: NavigationViewModel) {
            self.firstRoute = firstRoute
            self.navigationViewModel = navigationViewModel
        }

        func setUp() -> UINavigationController {
            let rootVC = makeHostingController(route: firstRoute)
            let navController = UINavigationController(rootViewController: rootVC)
            navController.delegate = self
            self.navigationController = navController

            navigationViewModel.$states
                .receive(on: DispatchQueue.main)
                .sink { [weak self] states in
                    self?.sync(states: states)
                }
                .store(in: &cancellables)

            return navController
        }

        // MARK: - Hosting-controller factory

        /// Creates a `UIHostingController` whose generic parameter is the
        /// concrete `RouteView` type, so Xcode labels it
        /// `UIHostingController<HomeView>` rather than
        /// `UIHostingController<AnyView>`.
        private func makeHostingController<R: Routable>(route: R) -> UIViewController {
            let vc = UIHostingController(rootView: route.view().environmentObject(navigationViewModel))
            vc.navigationItem.title = route.title
            return vc
        }

        // MARK: - State synchronisation

        private func sync(states: [NavigationState]) {
            guard let navController = navigationController else { return }
            syncPushStack(states: states, in: navController)
            syncModal(states: states, in: navController)
        }

        private func syncPushStack(states: [NavigationState], in navController: UINavigationController) {
            let pushStates = states.filter { $0.presentationType == .push }
            let currentVCs = navController.viewControllers
            let expectedCount = 1 + pushStates.count
            // Count-based comparison is sufficient because NavigationViewModel
            // only ever appends or removes states from the end; it never replaces
            // a state in the middle of the array.
            guard currentVCs.count != expectedCount else { return }

            if currentVCs.count < expectedCount {
                // Append view controllers for push states that are not yet on the stack.
                // dropFirst is used instead of a raw subscript so the call is safe even
                // if currentVCs is unexpectedly empty.
                var vcs = currentVCs
                for state in pushStates.dropFirst(max(0, currentVCs.count - 1)) {
                    vcs.append(state.makeViewController(navigationViewModel: navigationViewModel))
                }
                navController.setViewControllers(vcs, animated: true)
            } else {
                // Pop back to the expected depth.
                navController.setViewControllers(Array(currentVCs.prefix(expectedCount)), animated: true)
            }
        }

        private func syncModal(states: [NavigationState], in navController: UINavigationController) {
            let modalState = states.last {
                $0.presentationType == .present || $0.presentationType == .presentFullScreen
            }

            if let modalState = modalState {
                guard presentedModalStateID != modalState.id else { return }
                // Present from the navigation controller itself so that the
                // presenting VC is always the same regardless of push depth.
                guard navController.presentedViewController == nil else { return }
                presentedModalStateID = modalState.id

                let modalVC = modalState.makeViewController(navigationViewModel: navigationViewModel)
                if modalState.presentationType == .presentFullScreen {
                    modalVC.modalPresentationStyle = .fullScreen
                }
                navController.present(modalVC, animated: true) { [weak modalVC, weak self] in
                    // Set the delegate in the completion block as a safety net.
                    modalVC?.presentationController?.delegate = self
                }
                // UIKit creates the presentation controller synchronously during the
                // present(_:animated:) call, so assign the delegate immediately as well.
                modalVC.presentationController?.delegate = self
            } else {
                guard presentedModalStateID != nil else { return }
                presentedModalStateID = nil
                navController.presentedViewController?.dismiss(animated: true)
            }
        }

        // MARK: - UINavigationControllerDelegate

        /// Syncs a swipe-back (interactive pop) back into `NavigationViewModel`.
        public func navigationController(
            _ navigationController: UINavigationController,
            didShow viewController: UIViewController,
            animated: Bool
        ) {
            let newPushCount = navigationController.viewControllers.count - 1
            let pushStates = navigationViewModel.states.filter { $0.presentationType == .push }
            guard newPushCount < pushStates.count else { return }

            let toKeep = Set(pushStates.prefix(newPushCount).map(\.id))
            navigationViewModel.states = navigationViewModel.states.filter { state in
                state.presentationType != .push || toKeep.contains(state.id)
            }
        }

        // MARK: - UIAdaptivePresentationControllerDelegate

        /// Syncs an interactive sheet-dismiss (swipe down) back into `NavigationViewModel`.
        public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            guard presentedModalStateID != nil else { return }
            presentedModalStateID = nil
            if let lastModalIndex = navigationViewModel.states.lastIndex(where: {
                $0.presentationType == .present || $0.presentationType == .presentFullScreen
            }) {
                navigationViewModel.states.remove(at: lastModalIndex)
            }
        }
    }
}
