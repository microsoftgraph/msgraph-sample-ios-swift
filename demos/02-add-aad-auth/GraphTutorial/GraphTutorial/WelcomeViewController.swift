//
//  WelcomeViewController.swift
//  GraphTutorial
//
//  Created by Jason Johnston on 8/16/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
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
        self.userDisplayName.sizeToFit()
        self.userEmail.text = "default@contoso.com"
        self.userEmail.sizeToFit()
    }
    
    @IBAction func signOut() {
        AuthenticationManager.instance.signOut()
        self.performSegue(withIdentifier: "userSignedOut", sender: nil)
    }
}
