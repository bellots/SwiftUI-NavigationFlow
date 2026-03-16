//
//  ProfileView.swift
//  TestRouterNavigation
//

import SwiftUI
import SwiftUINavigationFlow

struct ProfileView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.purple)
            Text("Jane Doe")
                .font(.title2)
                .bold()
            Text("jane.doe@example.com")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Divider()
                .padding(.horizontal)
            Button {
                navigationViewModel.states.append(
                    NavigationState(route: ProfileRoute.profileSettings, presentationType: .push)
                )
            } label: {
                Label("Settings", systemImage: "gearshape")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(.horizontal)
            Spacer()
        }
        .padding(.top, 40)
    }
}
