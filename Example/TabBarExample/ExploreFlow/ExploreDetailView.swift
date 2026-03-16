//
//  ExploreDetailView.swift
//  TestRouterNavigation
//

import SwiftUI
import SwiftUINavigationFlow

struct ExploreDetailView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "text.below.photo.fill")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            Text("Results for this category will appear here.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
        .padding(.top, 40)
    }
}
