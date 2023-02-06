//
//  ModalView.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 30/12/22.
//

import SwiftUI
import SwiftUINavigationFlow

struct ModalView: View {
    @StateObject var secondNavigationViewModel: NavigationViewModel = NavigationViewModel()
    // Questo ⬇️ non riesce a passare al secondo navigationFlow, anche se aggiungo il modifier environmentObject.
    @EnvironmentObject var firstNavigationViewModel: NavigationViewModel

    var body: some View {
        NavigationFlow<SecondRouteFlow>(firstRoute: .secondFirst)
            .environmentObject(secondNavigationViewModel)
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
