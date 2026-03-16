//
//  ProfileSettingsView.swift
//  TestRouterNavigation
//

import SwiftUI
import SwiftUINavigationFlow

struct ProfileSettingsView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel

    var body: some View {
        List {
            Section("Account") {
                Label("Edit Profile", systemImage: "person.crop.circle")
                Label("Change Password", systemImage: "lock")
            }
            Section("Preferences") {
                Label("Notifications", systemImage: "bell")
                Label("Privacy", systemImage: "hand.raised")
            }
            Section {
                Button(role: .destructive) {
                    navigationViewModel.dismissCurrent()
                } label: {
                    Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }
        }
    }
}
