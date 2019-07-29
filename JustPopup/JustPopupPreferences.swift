//
//  JustPopupPreferences.swift
//  JustPopup
//
//  Created by Валерий Акатов on 24.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import Foundation

public class JustPopupPreferences {

    /**
     Indicates if JustPopups should use scene pattern (introduced in iOS 13). Popups may not appear if value is not set up properly
    
     Set this property with `JustPopupPreferences` singleton somewhere like app delegate
     
            JustPopupPreferences.shared.shouldFollowScenePattern = true
    */
    public var shouldFollowScenePattern: Bool = false
    
    public static let shared = JustPopupPreferences()
    
    private init() {}

}
