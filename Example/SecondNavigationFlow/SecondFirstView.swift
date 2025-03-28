//
//  SecondFirstView.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 30/12/22.
//

import SwiftUI
import SwiftUINavigationFlow

struct SecondFirstView: View {
    @EnvironmentObject var secondNavViewModel: NavigationViewModel
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            VStack {
                Text("Hello, World!")
                Button {
                    secondNavViewModel.parentNavigationViewModel?.dismissCurrent(forced: true)
                    print("here should dismiss parent's navigationViewModel in some way")
                } label: {
                    Text("Close the modal navigationController")
                }
                Button {
                    let navigationState = NavigationState(route: SecondRouteFlow.secondSecond, presentationType: .push)
                    secondNavViewModel.states.append(navigationState)
                } label: {
                    Text("Go to second second View")
                }
            }
        }
    }
}

struct SecondFirstView_Previews: PreviewProvider {
    static var previews: some View {
        SecondFirstView()
    }
}
