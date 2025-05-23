//
//  NavigationFlow.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import Foundation
import SwiftUI

@MainActor public struct NavigationFlow<T: Routable>: UIViewControllerRepresentable {

    public typealias UIViewControllerType = UINavigationController
    
    @ObservedObject var navigationViewModel: NavigationViewModel
    
    var firstRoute: T

    public init (firstRoute: T,
                 navigationViewModel: NavigationViewModel) {
        self.firstRoute = firstRoute
        self.navigationViewModel = navigationViewModel
    }

    public func makeUIViewController(context: Context) -> UINavigationController {
        let state = firstRoute
        return UINavigationController(rootViewController: viewController(from: state))
    }

    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        if let oldPresentationType = navigationViewModel.oldPresentationType {
            if !navigationViewModel.hasForcedDismiss {
                return
            }
            else {
                switch oldPresentationType {
                case .push:
                    uiViewController.popViewController(animated: true)
                case .present:
                    uiViewController.presentedViewController?.dismiss(animated: true) {
                        navigationViewModel.dismissingCompletion?()
                    }
                case .presentFullScreen:
                    uiViewController.presentedViewController?.dismiss(animated: true) {
                        navigationViewModel.dismissingCompletion?()
                    }
                }
                return
            }
        }
        else {
            if let lastNavState = navigationViewModel.states.last {
                let toPush = viewController(from: lastNavState.route)
                switch lastNavState.presentationType {
                case .push:
                    uiViewController.pushViewController(toPush, animated: true)
                case .present:
                    uiViewController.present(toPush, animated: true)
                case .presentFullScreen:
                    toPush.modalPresentationStyle = .overFullScreen
                    toPush.modalTransitionStyle = .crossDissolve
                    uiViewController.present(toPush, animated: true)
                }
            }
        }
    }

    fileprivate func viewController<Route: Routable>(from route: Route) -> UIViewController {
        return MyUIHostingController(rootView: route.view().environmentObject(navigationViewModel), title: route.title, color: route.color, showNavigationBar: route.showNavigationBar) {
            if navigationViewModel.hasForcedDismiss {
                navigationViewModel.hasForcedDismiss = false
                return
            }
            navigationViewModel.dismissCurrent(forced: false, completion: nil)
        }
    }
}
