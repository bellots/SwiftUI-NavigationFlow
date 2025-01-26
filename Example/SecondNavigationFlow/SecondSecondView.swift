//
//  SecondSecondView.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 30/12/22.
//

import SwiftUI
import SwiftUINavigationFlow

struct SecondSecondView: View {

    @EnvironmentObject var secondNavViewModel: NavigationViewModel
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button {
                secondNavViewModel.dismissCurrent(forced: true)
            } label: {
                Text("Back")
            }
            Button {
                let state = NavigationState(route: SecondRouteFlow.thirdSecond, presentationType: .presentFullScreen)
                secondNavViewModel.states.append(state)
            } label: {
                Text("Show another modal")
            }
            Button {
                secondNavViewModel.parentNavigationViewModel?.dismissCurrent(forced: true)
            } label: {
                Text("Dismiss first modal")
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color.green)
        .ignoresSafeArea()

    }
}

struct SecondSecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondSecondView()
    }
}
