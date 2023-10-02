//
//  Routable.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 11/01/23.
//

import Foundation
import SwiftUI

public protocol Routable: Hashable {
    func view() -> AnyView
    var title: String? { get }
    var color: UIColor { get }
    var showNavigationBar: Bool { get }
}
