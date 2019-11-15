//
//  SignInViewController.swift
//  GraphTutorial
//
//  Copyright © 2019 Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit

class SignInViewController: UIViewController {

    private let spinner = SpinnerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // See if a user is already signed in
        spinner.start(container: self)

        AuthenticationManager.instance.getTokenSilently {
            (token: String?, error: Error?) in

            DispatchQueue.main.async {
                self.spinner.stop()

                guard let _ = token, error == nil else {
                    // If there is no token or if there's an error,
                    // no user is signed in, so stay here
                    return
                }

                // Since we got a token, a user is signed in
                // Go to welcome page
                self.performSegue(withIdentifier: "userSignedIn", sender: nil)
            }
        }
    }

    @IBAction func signIn() {
        spinner.start(container: self)

        // Do an interactive sign in
        AuthenticationManager.instance.getTokenInteractively(parentView: self) {
            (token: String?, error: Error?) in

            DispatchQueue.main.async {
                self.spinner.stop()

                guard let _ = token, error == nil else {
                    // Show the error and stay on the sign-in page
                    let alert = UIAlertController(title: "Error signing in",
                                                  message: error.debugDescription,
                                                  preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }

                // Signed in successfully
                // Go to welcome page
                self.performSegue(withIdentifier: "userSignedIn", sender: nil)
            }
        }
    }
}
