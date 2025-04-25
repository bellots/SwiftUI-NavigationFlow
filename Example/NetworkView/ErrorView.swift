

import SwiftUI
import SwiftUINavigationFlow

struct ErrorView: View {
    @EnvironmentObject var navViewModel: NavigationViewModel
    
    var body: some View {
        VStack {
            Text("Something went wrong!")
                .foregroundColor(.white)

            Button {
                navViewModel.dismissCurrent(forced: true)
            } label: {
                Text("Try again!")
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
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

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let navViewModel = NavigationViewModel(parentNavigationViewModel: nil)
        
        return ErrorView()
            .environmentObject(navViewModel)
    }
}
