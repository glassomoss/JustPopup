//
//  JustPopup.swift
//  G5
//
//  Created by Mefodiy Akatov on 18.07.2019.
//  Copyright © 2019 Mefodiy Akatov. All rights reserved.
//

#if canImport(UIKit)

import SwiftUI
import Combine

public protocol AnyPopupController: class {

    var normalWindow: UIWindow { get set }
    var popupWindow: UIWindow? { get set }
    var popupController: UIViewController! { get set }

    // MARK: - Customization variables

    var animationDuration: TimeInterval { get set }
    var presentationDuration: TimeInterval? { get set }
    var cornerRadius: CGFloat { get set }
    var presentationStyle: PopupAnimationType { get set }
    var dismissionStyle: PopupAnimationType { get set }
    var dismissOnTap: Bool { get set }
    var fadesBackground: Bool { get set }

    
    // MARK: - Showing
    
    /// Just shows the popup and that's it
    func showPopup()
    
    /**
        Use this method to make popup hidden after some time
     
        You may use it like this:
            
            popup
                .withPresentationDuration(3)
                .showPopup()
     
        - parameter duration:
        Duration of showing the popup before it closes
        
        - warning:
        Be sure not to use .now() in duration as it's
        already used in implementation
     */
    func withPresentationDuration(_ duration: TimeInterval?) -> Self
    
    /**
        Utility method that explicitly sets the background faded
     
        Theoretically might be used when writing custom popup,
        but I doubt if there is any sense in doing it
    */
    func setBackgroundFaded(_ faded: Bool)


    // MARK: - Hiding
    
    /// Just hides the popup and that's it
    func hidePopup()
    
    /**
        Use this method to make popup close after given publisher emits
       
        Note that it closes popup when the publisher emits any value
        and after that subscription automatically terminates.

        - parameter publisher:
            Some publisher with Any output type and Never failure type
    */
    func subscribeToClosingPublisher<T>(_ publisher: AnyPublisher<T, Never>) -> Self

    // MARK: - Customization

    func withAnimationDuration(_ duration: TimeInterval) -> Self
    func withCornerRadius(_ radius: CGFloat) -> Self
    func withPresentationStyle(_ style: PopupAnimationType) -> Self
    func withDismissionStyle(_ style: PopupAnimationType) -> Self
    func dismissOnTap(_ bool: Bool) -> Self
    func fadesBackground(_ bool: Bool) -> Self

}

public extension AnyPopupController {

    func makeSelfKeyWindow() {
        popupWindow = rightWindow()
        popupWindow?.frame = UIScreen.main.bounds
        popupWindow?.backgroundColor = .clear
        popupWindow?.windowLevel = UIWindow.Level.statusBar + 1
        popupWindow?.rootViewController = self as? UIViewController
        popupWindow?.makeKeyAndVisible()
    }
    
    func rightWindow() -> UIWindow {
        if JustPopupPreferences.shared.shouldFollowScenePattern {
            let windowScene = UIApplication.shared
                .connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first
            if let windowScene = windowScene as? UIWindowScene {
                return UIWindow(windowScene: windowScene)
            }
        }
        return UIWindow()
    }

    func resignFromKeyWindow() {
        popupWindow?.rootViewController = nil
        popupWindow = nil
        normalWindow.makeKeyAndVisible()
    }

    func showPopup() {
        makeSelfKeyWindow()
        if fadesBackground  {
            setBackgroundFaded(true)
        }
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
    
    func withDismissionStyle(_ style: PopupAnimationType) -> Self {
        dismissionStyle = style
        return self
    }
    
    func withCornerRadius(_ radius: CGFloat) -> Self {
        cornerRadius = radius
        return self
    }
    
    func dismissOnTap(_ bool: Bool = true) -> Self {
        dismissOnTap = bool
        return self
    }

    func fadesBackground(_ bool: Bool) -> Self {
        fadesBackground = bool
        return self
    }
    
    func subscribeToClosingPublisher<T>(_ publisher: AnyPublisher<T, Never>) -> Self {
        let subscriber = Subscribers.SinkFirstAndCancel<T> { [weak self] _ in
            self?.hidePopup()
        }
        publisher
            .receive(on: RunLoop.main)
            .subscribe(subscriber)
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

#endif
