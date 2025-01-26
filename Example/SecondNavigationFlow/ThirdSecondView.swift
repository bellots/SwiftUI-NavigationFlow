//
//  ThirdSecondView.swift
//  SwiftUI-NavigationFlow
//
//  Created by Andrea Bellotto on 26/01/25.
//

import SwiftUI
import SwiftUINavigationFlow

struct ThirdSecondView: View {

    @EnvironmentObject var firstNavViewModel: NavigationViewModel
    @EnvironmentObject var secondNavViewModel: NavigationViewModel
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button {
                secondNavViewModel.dismissCurrent(forced: true)
            } label: {
                Text("Back")
                    .foregroundColor(.white)
            }
        }
        .padding(20)
        .background(
            Color.blue
                .cornerRadius(20)
                .shadow(
                radius: 10
            )
        )
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()

    }
}

struct ThirdSecondView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdSecondView()
    }
}
