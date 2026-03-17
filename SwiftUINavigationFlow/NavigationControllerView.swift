//
//  NavigationControllerView.swift
//  SwiftUINavigationFlow
//
//  A UIViewControllerRepresentable that drives push navigation through a
//  UINavigationController.  Every destination is hosted in its own
//  UIHostingController, so Xcode's view-hierarchy / 3D debugger can show
//  each screen as a discrete entry (e.g. "HomeView", "HomeDetailView") rather
//  than hiding everything inside a single, opaque SwiftUI NavigationStack host.
//

import SwiftUI
import UIKit

struct NavigationControllerView<T: Routable>: UIViewControllerRepresentable {

    let firstRoute: T
    @ObservedObject var navigationViewModel: NavigationViewModel

    // MARK: - UIViewControllerRepresentable

    func makeCoordinator() -> Coordinator {
        Coordinator(navigationViewModel: navigationViewModel)
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        // Root screen: use the concrete T.RouteView so the hosting controller
        // carries a meaningful generic type parameter in the debug hierarchy.
        let rootVC = UIHostingController(
            rootView: firstRoute.view()
                .environmentObject(navigationViewModel)
        )
        rootVC.title = firstRoute.title

        let navController = UINavigationController(rootViewController: rootVC)
        navController.delegate = context.coordinator
        context.coordinator.navigationController = navController

        // Reflect any states that already existed before this VC was created.
        context.coordinator.sync(to: navigationViewModel.states, animated: false)
        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        context.coordinator.sync(to: navigationViewModel.states, animated: true)
    }

    // MARK: - Coordinator

    final class Coordinator: NSObject, UINavigationControllerDelegate {

        weak var navigationController: UINavigationController?
        let navigationViewModel: NavigationViewModel

        init(navigationViewModel: NavigationViewModel) {
            self.navigationViewModel = navigationViewModel
        }

        /// Reconcile the UINavigationController stack with the push states in the model.
        func sync(to states: [NavigationState], animated: Bool) {
            guard let navController = navigationController else { return }

            let pushStates = states.filter { $0.presentationType == .push }
            let currentPushDepth = navController.viewControllers.count - 1 // root is index 0

            if pushStates.count > currentPushDepth {
                // Push any new screens that are not yet in the stack.
                for state in pushStates.dropFirst(currentPushDepth) {
                    let vc = state.makeHostingController(navigationViewModel: navigationViewModel)
                    // Animate only the final push so multiple rapid additions look natural.
                    let isLast = state.id == pushStates.last?.id
                    navController.pushViewController(vc, animated: animated && isLast)
                }
            } else if pushStates.count < currentPushDepth {
                // Pop back to the correct depth.
                let targetVC = navController.viewControllers[pushStates.count]
                navController.popToViewController(targetVC, animated: animated)
            }
        }

        // MARK: UINavigationControllerDelegate

        func navigationController(
            _ navigationController: UINavigationController,
            didShow viewController: UIViewController,
            animated: Bool
        ) {
            // If UIKit and the model are already in sync this was a programmatic
            // navigation; nothing to do.
            let pushDepth = navigationController.viewControllers.count - 1
            let modelPushCount = navigationViewModel.states
                .filter { $0.presentationType == .push }.count
            guard pushDepth < modelPushCount else { return }

            // The user performed a swipe-back or tapped the back button —
            // mirror the UIKit state back into the model.
            let toRemove = modelPushCount - pushDepth
            var states = navigationViewModel.states
            for _ in 0..<toRemove {
                if let lastPushIndex = states.lastIndex(where: { $0.presentationType == .push }) {
                    states.remove(at: lastPushIndex)
                }
            }
            navigationViewModel.states = states
        }
    }
}
