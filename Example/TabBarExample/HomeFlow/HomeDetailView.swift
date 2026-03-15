//
//  HomeDetailView.swift
//  TestRouterNavigation
//

import SwiftUI
import SwiftUINavigationFlow

struct HomeDetailView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "doc.text.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            Text("Article content goes here.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
        .padding(.top, 40)
    }
}
