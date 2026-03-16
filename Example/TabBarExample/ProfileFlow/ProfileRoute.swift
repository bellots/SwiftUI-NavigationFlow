//
//  ProfileRoute.swift
//  TestRouterNavigation
//

import SwiftUI
import SwiftUINavigationFlow

enum ProfileRoute: Routable {
    case profile
    case profileSettings

    @ViewBuilder
    func view() -> some View {
        switch self {
        case .profile:
            ProfileView()
        case .profileSettings:
            ProfileSettingsView()
        }
    }

    var title: String? {
        switch self {
        case .profile:
            return "Profile"
        case .profileSettings:
            return "Settings"
        }
    }
}
