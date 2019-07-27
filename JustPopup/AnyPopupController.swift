//
//  PopupController.swift
//  G5
//
//  Created by Валерий Акатов on 18.07.2019.
//  Copyright © 2019 Валерий Акатов. All rights reserved.
//

import SwiftUI
import Combine

public protocol AnyPopupController: class {

    var normalWindow: UIWindow { get set }
    var popupWindow: UIWindow? { get set }
    var popupController: UIViewController! { get set }
    var animationDuration: TimeInterval { get set }
    var presentationDuration: TimeInterval? { get set }
    var cornerRadius: CGFloat { get set }
    var presentationStyle: PopupAnimationType { get set }
    var dismissionStyle: PopupAnimationType { get set }

    func showPopup()
    func hidePopup()
    func setBackgroundFaded(_ faded: Bool)

    func withAnimationDuration(_ duration: TimeInterval) -> Self
    func withPresentationDuration(_ duration: TimeInterval?) -> Self
    func withCornerRadius(_ radius: CGFloat) -> Self
    func withPresentationStyle(_ style: PopupAnimationType) -> Self
    func withDissmissionStyle(_ style: PopupAnimationType) -> Self

}

public extension AnyPopupController {
    
    func makeSelfKeyWindow() {
        if JustPopupPreferences.shared.shouldFollowScenePattern {
            let windowScene = UIApplication.shared.connectedScenes.first
            if let windowScene = windowScene as? UIWindowScene {
                popupWindow = UIWindow(windowScene: windowScene)
            }
        } else {
            popupWindow = UIWindow()
        }
        popupWindow?.frame = UIScreen.main.bounds
        popupWindow?.backgroundColor = .clear
        popupWindow?.windowLevel = UIWindow.Level.statusBar + 1
        if let self = self as? UIViewController {
            popupWindow?.rootViewController = self
        }
        popupWindow?.makeKeyAndVisible()
    }
    
    func resignFromKeyWindow() {
        popupWindow?.rootViewController = nil
        popupWindow = nil
        normalWindow.makeKeyAndVisible()
    }

    func showPopup() {
        makeSelfKeyWindow()
        setBackgroundFaded(true)
        let popupView = popupController.view
        popupView?.alpha = 0
        
        switch self.presentationStyle {
        case .crossDisolve:
            break
        case .fromBottom:
            popupView?.transform = CGAffineTransform(translationX: 0, y: 500)
        case .fromUp:
            popupView?.transform = CGAffineTransform(translationX: 0, y: -500)
        }
        
        UIView.animate(withDuration: animationDuration, animations: {
            popupView?.alpha = 1
            popupView?.transform = .identity
        }, completion: { _ in
            if let self_ = self as? UIViewController {
                self.popupController.didMove(toParent: self_)
            }
            NotificationCenter.default.post(name: .didViewAppearInPopup, object: true)
        })

        if let duration = presentationDuration {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                self.hidePopup()
            })
        }
    }
    
    func hidePopup() {
        setBackgroundFaded(false)
        let popupView = popupController.view
        
        UIView.animate(withDuration: animationDuration, animations: {
            switch self.dismissionStyle {
            case .crossDisolve:
                break
            case .fromBottom:
                popupView?.transform = CGAffineTransform(translationX: 0, y: 500)
            case .fromUp:
                popupView?.transform = CGAffineTransform(translationX: 0, y: -500)
            }
            popupView?.alpha = 0
        }, completion: { _ in
            self.resignFromKeyWindow()
        })
    }

    func withAnimationDuration(_ duration: TimeInterval) -> Self {
        animationDuration = duration
        return self
    }
    
    func withPresentationDuration(_ duration: TimeInterval?) -> Self {
        presentationDuration = duration
        return self
    }
    
    func withPresentationStyle(_ style: PopupAnimationType) -> Self {
        presentationStyle = style
        return self
    }
    
    func withDissmissionStyle(_ style: PopupAnimationType) -> Self {
        dismissionStyle = style
        return self
    }
    
    func withCornerRadius(_ radius: CGFloat) -> Self {
        cornerRadius = radius
        return self
    }

}

public extension AnyPopupController where Self: UIViewController {
    
    func setBackgroundFaded(_ faded: Bool) {
        UIView.animate(withDuration: animationDuration + 0.1) {
            let color = faded ? UIColor.black.withAlphaComponent(0.75) : .clear
            self.view.backgroundColor = color
        }
    }

}

