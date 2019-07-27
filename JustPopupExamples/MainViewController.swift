//
//  MainViewController.swift
//  PopupControllerShowcase
//
//  Created by Валерий Акатов on 21.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import UIKit
import PopupController

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
        guard let window = view.window else { return }
//        let swiftView = ContentView()
//        popup = PopupHostingViewController(rootView: swiftView, fromWindow: window)
//            .withCornerRadius(20)
        let simpleView = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
        simpleView.backgroundColor = .systemOrange
        let controller = UIViewController()
        controller.view = simpleView
        popup = PopupContainerViewController(popupController: controller, fromWindow: window)
        popup?.showPopup()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.popup?.hidePopup()
            self.popup = nil
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
