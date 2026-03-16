//
//  SecondView.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import SwiftUI
import SwiftUINavigationFlow

struct SecondView: View {
    @EnvironmentObject var firstNavigationViewModel: NavigationViewModel

    var body: some View {
        VStack {
            Text("Questa è la second view!!")
            Button {
                
                let navigationState = NavigationState(route: TestRoute.firstView, presentationType: .push)
//                firstNavigationViewModel.states.append(navigationState)
                firstNavigationViewModel
                    .dismissCurrent(forced: true)
            } label: {
                Text("Torna indietro")
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
