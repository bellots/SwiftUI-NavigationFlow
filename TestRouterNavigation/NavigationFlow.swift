//
//  NavigationFlow.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import Foundation
import SwiftUI

@MainActor struct NavigationFlow<T: Routable>: UIViewControllerRepresentable {

    typealias UIViewControllerType = UINavigationController

    @EnvironmentObject var navigationViewModel: NavigationViewModel

    var firstRoute: T

    func makeUIViewController(context: Context) -> UINavigationController {
        let state = firstRoute
        return UINavigationController(rootViewController: viewController(from: state))
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        if let oldPresentationType = navigationViewModel.oldPresentationType {
            if !navigationViewModel.hasForcedDismiss {
                return
            }
            else {
                switch oldPresentationType {
                case .push:
                    uiViewController.popViewController(animated: true)
                case .present:
                    uiViewController.presentedViewController?.dismiss(animated: true)
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
                }
            }
        }
    }

    fileprivate func viewController<T: Routable>(from route: T) -> UIViewController {
        return MyUIHostingController(rootView: route.view().environmentObject(navigationViewModel), title: route.title) {
            if navigationViewModel.hasForcedDismiss {
                navigationViewModel.hasForcedDismiss = false
                return
            }
            navigationViewModel.dismissCurrent(forced: false)
        }
    }
}
