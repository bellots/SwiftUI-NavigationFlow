//
//  ContentView.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import SwiftUI
import SwiftUINavigationFlow

struct ContentView: View {
    @StateObject var viewModel: NavigationViewModel = NavigationViewModel(parentNavigationViewModel: nil)

    var body: some View {
        NavigationFlow<TestRoute>(firstRoute: .firstView, navigationViewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
