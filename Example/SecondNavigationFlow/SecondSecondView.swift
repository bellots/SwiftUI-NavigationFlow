//
//  SecondSecondView.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 30/12/22.
//

import SwiftUI
import SwiftUINavigationFlow

struct SecondSecondView: View {

    @EnvironmentObject var firstNavViewModel: NavigationViewModel
    @EnvironmentObject var secondNavViewModel: NavigationViewModel
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button {
                secondNavViewModel.dismissCurrent(forced: true)
            } label: {
                Text("Back")
            }

        }
    }
}

struct SecondSecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondSecondView()
    }
}
