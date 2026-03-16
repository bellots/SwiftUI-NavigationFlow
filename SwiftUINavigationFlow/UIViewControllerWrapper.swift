//
//  UIViewControllerWrapper.swift
//  SwiftUINavigationFlow
//

import Foundation
import SwiftUI

/// A SwiftUI view that wraps a `UIViewController`, enabling UIKit view controllers
/// to be embedded within SwiftUI-based navigation flows managed by `NavigationFlow`.
///
/// Example usage inside a `Routable` implementation:
/// ```swift
/// case myLegacyScreen:
///     UIViewControllerWrapper {
///         let vc = MyLegacyViewController()
///         vc.configure(with: someData)
///         return vc
///     }
/// ```
public struct UIViewControllerWrapper: UIViewControllerRepresentable {
    private let makeViewController: () -> UIViewController

    public init(_ makeViewController: @escaping () -> UIViewController) {
        self.makeViewController = makeViewController
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        makeViewController()
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

