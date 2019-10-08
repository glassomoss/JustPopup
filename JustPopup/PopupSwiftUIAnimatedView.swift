//
//  PopupSwiftUIAnimatedView.swift
//  JustPopup
//
//  Created by Mefodiy Akatov on 21.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import Combine

public protocol PopupSwiftUIAnimatedView {}

public extension PopupSwiftUIAnimatedView {
    
    func swiftUIViewAppearPublisher() -> AnyPublisher<Bool, Never> {
        return NotificationCenter.default
            .publisher(for: Notification.Name.didViewAppearInPopup)
            .compactMap { $0.object as? Bool }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

#endif
