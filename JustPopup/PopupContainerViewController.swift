//
//  PopupViewController.swift
//  JustPopup
//
//  Created by Валерий Акатов on 23.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import UIKit

public class PopupContainerViewController: UIViewController, AnyPopupController {

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

    public init(popupView: UIView, fromWindow: UIWindow? = nil) {
        self.normalWindow = fromWindow ?? UIApplication.topWindow()
        super.init(nibName: nil, bundle: nil)
        setupPopupController(from: popupView)
        popupController.view.layer.cornerRadius = cornerRadius
        view.addSubview(popupController.view)
    }

    public init(popupController: UIViewController, fromWindow: UIWindow? = nil) {
        self.normalWindow = fromWindow ?? UIApplication.topWindow()
        super.init(nibName: nil, bundle: nil)
        setupPopupController(from: popupController)
        popupController.view.layer.cornerRadius = cornerRadius
        view.addSubview(popupController.view)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .clear
    }

    private func setupPopupController(from view: UIView) {
        popupController = PopupViewController(popupView: view)
        addChild(popupController)
        let size = UIScreen.main.bounds.size
        popupController.view.bounds.size = CGSize(width: size.width - 40, height: size.height - 60)
        popupController.view.center = CGPoint(x: size.width / 2, y: size.height / 2)
    }

    private func setupPopupController(from controller: UIViewController) {
        popupController = controller
        addChild(popupController)
        let size = UIScreen.main.bounds.size
        popupController.view.bounds.size = CGSize(width: size.width - 40, height: size.height - 60)
        popupController.view.center = CGPoint(x: size.width / 2, y: size.height / 2)
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
