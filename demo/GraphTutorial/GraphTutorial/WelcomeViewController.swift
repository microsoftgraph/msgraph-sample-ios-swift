//
//  WelcomeViewController.swift
//  GraphTutorial
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license.
//

import UIKit
import MSGraphClientModels

class WelcomeViewController: UIViewController {
    @IBOutlet var userProfilePhoto: UIImageView!
    @IBOutlet var userDisplayName: UILabel!
    @IBOutlet var userEmail: UILabel!

    private let spinner = SpinnerViewController()

    // <ViewDidLoadSnippet>
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.spinner.start(container: self)

        // Get the signed-in user
        self.userProfilePhoto.image = UIImage(imageLiteralResourceName: "DefaultUserPhoto")

        GraphManager.instance.getMe {
            (user: MSGraphUser?, error: Error?) in

            DispatchQueue.main.async {
                self.spinner.stop()

                guard let currentUser = user, error == nil else {
                    print("Error getting user: \(String(describing: error))")
                    return
                }

                // Set display name
                self.userDisplayName.text = currentUser.displayName ?? "Mysterious Stranger"
                self.userDisplayName.sizeToFit()

                // AAD users have email in the mail attribute
                // Personal accounts have email in the userPrincipalName attribute
                self.userEmail.text = currentUser.mail ?? currentUser.userPrincipalName ?? ""
                self.userEmail.sizeToFit()
                
                // Save the user's time zone
                GraphManager.instance.userTimeZone = currentUser.mailboxSettings?.timeZone ?? "UTC"
            }
        }
    }
    // </ViewDidLoadSnippet>
    
    // <SignOutSnippet>
    @IBAction func signOut() {
        AuthenticationManager.instance.signOut()
        self.performSegue(withIdentifier: "userSignedOut", sender: nil)
    }
    // </SignOutSnippet>
}
