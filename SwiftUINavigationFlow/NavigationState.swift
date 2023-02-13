//
//  NavigationState.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import Foundation
import SwiftUI

public enum PresentationType {
    case push
    case present
    case presentFullScreen
}

public struct NavigationState: Identifiable {
    public var id: UUID
    var route: any Routable
    var presentationType: PresentationType

    public init(id: UUID = UUID(), route: any Routable, presentationType: PresentationType) {
        self.id = id
        self.route = route
        self.presentationType = presentationType
    }
}
