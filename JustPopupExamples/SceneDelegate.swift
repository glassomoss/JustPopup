//
//  SceneDelegate.swift
//  JustPopupShowcase
//
//  Created by Валерий Акатов on 21.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = MainViewController(nibName: nil, bundle: nil)
            window?.makeKeyAndVisible()
        }
    }

}

