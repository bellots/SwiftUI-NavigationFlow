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
    var showNavigationBar: Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = color
        self.title = navigationTitle
        navigationItem.backButtonDisplayMode = .minimal
        self.view.backgroundColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = color
        self.title = navigationTitle
        self.navigationController?.navigationBar.isHidden = !showNavigationBar
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = color
        self.title = ""

        if self.isMovingFromParent {
            isPoppingBack()
        }
        if self.isBeingDismissed {
            isPoppingBack()
        }
    }

    init(rootView: Content, title: String?, color: UIColor, showNavigationBar: Bool, isPoppingBack: @escaping () -> Void) {
        self.isPoppingBack = isPoppingBack
        self.navigationTitle = title
        self.color = color
        self.showNavigationBar = showNavigationBar
        super.init(rootView: rootView)

    }

    override init(rootView: Content) {
        self.navigationTitle = nil
        isPoppingBack = { }
        self.color = .blue
        self.showNavigationBar = true
        super.init(rootView: rootView)

        // subscriptions to notifications will go here
    }

    /// required initializer
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

