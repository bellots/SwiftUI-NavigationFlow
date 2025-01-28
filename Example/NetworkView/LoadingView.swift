

import SwiftUI
import SwiftUINavigationFlow

struct LoadingView: View {
    @EnvironmentObject var navViewModel: NavigationViewModel
    
    var body: some View {
        VStack {
            Text("Loading! Please wait...")
                .foregroundColor(.white)
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

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        let navViewModel = NavigationViewModel(parentNavigationViewModel: nil)
        
        return LoadingView()
            .environmentObject(navViewModel)
    }
}
