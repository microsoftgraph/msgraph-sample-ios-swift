//
//  SignInViewController.swift
//  GraphTutorial
//
//  Created by Jason Johnston on 8/15/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signIn() {
        self.performSegue(withIdentifier: "userSignedIn", sender: nil)
    }
}
