//
//  SecondView.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import SwiftUI

struct SecondView: View {
    @EnvironmentObject var firstNavigationViewModel: NavigationViewModel

    var body: some View {
        VStack {
            Text("Questa è la second view!!")
            Button {
                firstNavigationViewModel.dismissCurrent(forced: true)
            } label: {
                Text("Torna indietro")
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
