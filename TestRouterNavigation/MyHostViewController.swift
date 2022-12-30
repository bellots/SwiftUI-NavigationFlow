//
//  MyHostViewController.swift
//  TestRouterNavigation
//
//  Created by Andrea Bellotto on 27/11/22.
//

import Foundation
import SwiftUI

class MyUIHostingController<Content>: UIHostingController<Content> where Content: View {
    var isPoppingBack: () -> Void
    var navigationTitle: String

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.title = navigationTitle
        navigationItem.backButtonDisplayMode = .minimal
        self.title = navigationTitle
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            isPoppingBack()
        }
        if self.isBeingDismissed {
            isPoppingBack()
        }
    }

    init(rootView: Content, title: String, isPoppingBack: @escaping () -> Void) {
        self.isPoppingBack = isPoppingBack
        self.navigationTitle = title
        super.init(rootView: rootView)

    }

    override init(rootView: Content) {
        self.navigationTitle = ""
        isPoppingBack = { }
        super.init(rootView: rootView)

        // subscriptions to notifications will go here
    }

    /// required initializer
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

