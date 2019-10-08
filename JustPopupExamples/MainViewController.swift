//
//  MainViewController.swift
//  JustPopupShowcase
//
//  Created by Mefodiy Akatov on 21.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import UIKit
import JustPopup
import Combine

class MainViewController: UIViewController {

    override func loadView() {
        super.loadView()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    
    private func setupButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        button.addTarget(self, action: #selector(showPopup), for: .touchUpInside)
        button.setTitle("Show popup", for: .normal)
        button.backgroundColor = .systemFill
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    var popup: AnyPopupController?
    
    @objc private func showPopup() {

        if Bool.random() {
            let swiftView = ContentView()
            popup = Popup(swiftView)
        } else {
            let simpleView = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
            simpleView.backgroundColor = .systemOrange
            popup = Popup(simpleView)
        }

        let publisher = PassthroughSubject<Void, Never>()

        popup?
            .withAnimationDuration(2)
            .withPresentationStyle(.fromBottom)
            .withDismissionStyle(.fromUp)
            .withCornerRadius(5)
            .fadesBackground(false)
            .dismissOnTap()
            .subscribeToClosingPublisher(publisher.eraseToAnyPublisher())
            .showPopup()

        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
            publisher.send(())
        })
    }

}
