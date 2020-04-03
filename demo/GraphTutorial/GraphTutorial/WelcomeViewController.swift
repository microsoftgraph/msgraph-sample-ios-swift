//
//  WelcomeViewController.swift
//  GraphTutorial
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var userProfilePhoto: UIImageView!
    @IBOutlet var userDisplayName: UILabel!
    @IBOutlet var userEmail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // TEMPORARY
        self.userProfilePhoto.image = UIImage(imageLiteralResourceName: "DefaultUserPhoto")
        self.userDisplayName.text = "Default User"
        self.userEmail.text = "default@contoso.com"
    }

    @IBAction func signOut() {
        self.performSegue(withIdentifier: "userSignedOut", sender: nil)
    }
}
