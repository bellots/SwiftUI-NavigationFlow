//
//  ModalView.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 30/12/22.
//

import SwiftUI
import SwiftUINavigationFlow

struct ModalView: View {
    @StateObject var secondNavigationViewModel: NavigationViewModel
    @EnvironmentObject var firstNavigationViewModel: NavigationViewModel

    var body: some View {
        NavigationFlow<SecondRouteFlow>(firstRoute: .secondFirst, navigationViewModel: secondNavigationViewModel)
            .onAppear {
                secondNavigationViewModel.parentNavigationViewModel = firstNavigationViewModel
            }
    }
    
    init() {
        self._secondNavigationViewModel = StateObject(wrappedValue: NavigationViewModel())
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
