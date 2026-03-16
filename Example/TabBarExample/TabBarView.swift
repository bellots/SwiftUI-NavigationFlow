//
//  TabBarView.swift
//  TestRouterNavigation
//
//  Demonstrates embedding three independent NavigationFlows inside a TabView.
//  Each tab owns its own NavigationViewModel so navigation state is fully
//  isolated — pushing a view in one tab never affects the others.
//

import SwiftUI
import SwiftUINavigationFlow

struct TabBarView: View {
    @StateObject private var homeViewModel = NavigationViewModel()
    @StateObject private var exploreViewModel = NavigationViewModel()
    @StateObject private var profileViewModel = NavigationViewModel()

    var body: some View {
        TabView {
            NavigationFlow<HomeRoute>(
                firstRoute: .home,
                navigationViewModel: homeViewModel
            )
            .tabItem {
                Label("Home", systemImage: "house")
            }

            NavigationFlow<ExploreRoute>(
                firstRoute: .explore,
                navigationViewModel: exploreViewModel
            )
            .tabItem {
                Label("Explore", systemImage: "magnifyingglass")
            }

            NavigationFlow<ProfileRoute>(
                firstRoute: .profile,
                navigationViewModel: profileViewModel
            )
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
