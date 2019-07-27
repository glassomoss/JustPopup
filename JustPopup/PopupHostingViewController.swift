//
//  PopupHostingViewController.swift
//  PopupController
//
//  Created by Валерий Акатов on 21.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import SwiftUI

public class PopupHostingViewController<Content: View>: UIViewController, AnyPopupController {
    
    public var normalWindow: UIWindow
    public var popupWindow: UIWindow?
    public var popupController: UIViewController!
    public var cornerRadius: CGFloat = 20 {
        didSet {
            popupController.view.layer.cornerRadius = cornerRadius
        }
    }
    public var animationDuration: TimeInterval = 0.3
    public var presentationDuration: TimeInterval?
    public var presentationStyle: PopupAnimationType = .fromBottom
    public var dismissionStyle: PopupAnimationType = .crossDisolve
    
    public init(rootView: Content, fromWindow: UIWindow) {
        self.normalWindow = fromWindow
        super.init(nibName: nil, bundle: nil)
        configureHostingController(from: rootView)
        popupController.view.layer.cornerRadius = cornerRadius
        view.addSubview(popupController.view)
    }
    
    public override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .clear
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHostingController<T: View>(from view: T) {
        popupController = UIHostingController(rootView: view)
        addChild(popupController)
        let size = UIScreen.main.bounds.size
        popupController.view.bounds.size = CGSize(width: size.width - 40, height: size.height - 60)
        popupController.view.center = CGPoint(x: size.width / 2, y: size.height / 2)
    }

}

