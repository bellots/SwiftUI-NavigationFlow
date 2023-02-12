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
    var navigationTitle: String?
    var color: UIColor

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = color
        self.title = navigationTitle
        navigationItem.backButtonDisplayMode = .minimal
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = color
        self.title = navigationTitle
//        if let navigationTitle {
//            self.title = navigationTitle
//        } else {
//            navigationController?.setNavigationBarHidden(true, animated: animated)
//        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = color
        self.title = navigationTitle

//        if let navigationTitle {
//            self.title = navigationTitle
//            navigationItem.backButtonDisplayMode = .minimal
//        } else {
//            navigationController?.setNavigationBarHidden(true, animated: animated)
//        }

        if self.isMovingFromParent {
            isPoppingBack()
        }
        if self.isBeingDismissed {
            isPoppingBack()
        }
    }

    init(rootView: Content, title: String?, color: UIColor, isPoppingBack: @escaping () -> Void) {
        self.isPoppingBack = isPoppingBack
        self.navigationTitle = title
        self.color = color
        super.init(rootView: rootView)

    }

    override init(rootView: Content) {
        self.navigationTitle = nil
        isPoppingBack = { }
        self.color = .blue
        super.init(rootView: rootView)

        // subscriptions to notifications will go here
    }

    /// required initializer
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

