//
//  ModalView.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 30/12/22.
//

import SwiftUI
import SwiftUINavigationFlow

struct ModalView: View {
    @ObservedObject var secondNavigationViewModel: NavigationViewModel
    // Questo ⬇️ non riesce a passare al secondo navigationFlow, anche se aggiungo il modifier environmentObject.
    @EnvironmentObject var firstNavigationViewModel: NavigationViewModel

    var body: some View {
        NavigationFlow<SecondRouteFlow>(firstRoute: .secondFirst, navigationViewModel: secondNavigationViewModel)
            .environmentObject(firstNavigationViewModel)
            .onAppear {
                secondNavigationViewModel.parentNavigationViewModel = firstNavigationViewModel
            }
    }
    
    init() {
        self.secondNavigationViewModel = NavigationViewModel(parentNavigationViewModel: nil)
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
