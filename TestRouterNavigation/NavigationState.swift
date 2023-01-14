//
//  NavigationState.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import Foundation
import SwiftUI

enum PresentationType {
    case push
    case present
}

struct NavigationState: Identifiable {
    var id: UUID
    var route: any Routable
    var presentationType: PresentationType

    init(id: UUID = UUID(), route: any Routable, presentationType: PresentationType) {
        self.id = id
        self.route = route
        self.presentationType = presentationType
    }
}
