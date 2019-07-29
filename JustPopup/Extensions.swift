//
//  Extensions.swift
//  JustPopup
//
//  Created by Валерий Акатов on 21.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import Foundation
import Combine

public extension Notification.Name {
    static let didViewAppearInPopup = Notification.Name("didViewAppearInPopup")
}

extension Subscribers {
    
    class SinkFirstAndCancel<Input>: Subscriber {
        typealias Failure = Never
        
        private var closure: (Input) -> Void
        private var subscription: Subscription?
        
        init(do closure: @escaping (Input) -> Void) {
            self.closure = closure
        }

        func receive(subscription: Subscription) {
            self.subscription = subscription
            subscription.request(.max(1))
        }
              
        func receive(_ input: Input) -> Subscribers.Demand {
            closure(input)
            subscription?.cancel()
            subscription = nil
            return .none
        }
        
        func receive(completion: Subscribers.Completion<Never>) {
            subscription?.cancel()
            subscription = nil
        }
    }

}
