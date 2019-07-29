//
//  AppDelegate.swift
//  JustPopupShowcase
//
//  Created by Валерий Акатов on 21.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import UIKit
import JustPopup

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        JustPopupPreferences.shared.shouldFollowScenePattern = true
        return true
    }

}

