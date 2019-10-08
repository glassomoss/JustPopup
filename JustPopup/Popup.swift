//
//  PopupViewController.swift
//  JustPopup
//
//  Created by Mefodiy Akatov on 23.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

#if canImport(UIKit)

import UIKit
import SwiftUI

public class Popup: UIViewController, AnyPopupController {

    public var normalWindow: UIWindow
    public var popupWindow: UIWindow?
    public var popupController: UIViewController!
    public var animationDuration: TimeInterval = 0.3
    public var presentationDuration: TimeInterval?
    public var cornerRadius: CGFloat = 20 {
        didSet {
            popupController.view.layer.cornerRadius = cornerRadius
        }
    }
    public var presentationStyle: PopupAnimationType = .fromBottom
    public var dismissionStyle: PopupAnimationType = .crossDisolve
    public var fadesBackground: Bool = true
    public var dismissOnTap: Bool = false

    public init(_ view: UIView, fromWindow: UIWindow? = nil) {
        self.normalWindow = fromWindow ?? UIApplication.topWindow()
        super.init(nibName: nil, bundle: nil)
        popupController = PopupViewController(popupView: view)
        setupPopupController()
    }

    public init(_ popupController: UIViewController, fromWindow: UIWindow? = nil) {
        self.normalWindow = fromWindow ?? UIApplication.topWindow()
        self.popupController = popupController
        super.init(nibName: nil, bundle: nil)
        setupPopupController()
    }

    public convenience init<T: View>(_ view: T, fromWindow: UIWindow? = nil) {
        self.init(UIHostingController(rootView: view), fromWindow: fromWindow)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .clear
    }

    private func setupPopupController() {
        addChild(popupController)
        let size = UIScreen.main.bounds.size
        popupController.view.bounds.size = CGSize(width: size.width - 40, height: size.height - 60)
        popupController.view.center = CGPoint(x: size.width / 2, y: size.height / 2)
        popupController.view.layer.cornerRadius = cornerRadius
        view.addSubview(popupController.view)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if dismissOnTap {
            hidePopup()
        }
    }

}

private class PopupViewController: UIViewController {

    var popupView: UIView

    public init(popupView: UIView) {
        self.popupView = popupView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()
        view = popupView
    }

}

#endif
