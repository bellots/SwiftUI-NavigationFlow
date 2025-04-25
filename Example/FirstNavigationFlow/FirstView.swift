//
//  FirstView.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import SwiftUI
import SwiftUINavigationFlow

struct FirstView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel

    var body: some View {
        VStack {
            Text("First View")
            Button {
                let navigationState = NavigationState(route: TestRoute.secondView, presentationType: .push)
                navigationViewModel.states.append(navigationState)
            } label: {
                Text("Go to secondView")
            }
            Button {
                navigationViewModel.states.append(.init(route: TestRoute.modalView, presentationType: .present))
            } label: {
                Text("Open modalView!")
            }
            
            Button {
                navigationViewModel.states.append(.init(route: TestRoute.loadingView, presentationType: .presentFullScreen))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    navigationViewModel.dismissCurrent(forced: true) {
                        navigationViewModel.states.append(.init(route: TestRoute.errorView, presentationType: .presentFullScreen))
                    }
                })
                
            } label: {
                Text("Try to launch a loader that shows an errorView later")
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
