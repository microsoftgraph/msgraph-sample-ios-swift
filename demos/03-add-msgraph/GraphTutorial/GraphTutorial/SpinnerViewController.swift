//
//  SpinnerViewController.swift
//  GraphTutorial
//
//  Created by Jason Johnston on 8/16/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {

    var spinner = UIActivityIndicatorView(style: .whiteLarge)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    public func start(container: UIViewController) {
        container.addChild(self)
        self.view.frame = container.view.frame
        container.view.addSubview(self.view)
        self.didMove(toParent: container)
    }

    public func stop() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
