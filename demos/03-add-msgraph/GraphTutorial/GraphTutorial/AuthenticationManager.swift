//
//  AuthenticationManager.swift
//  GraphTutorial
//
//  Copyright © 2019 Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation
import MSAL
import MSGraphClientSDK

// Implement the MSAuthenticationProvider interface so
// this class can be used as an auth provider for the Graph SDK
class AuthenticationManager: NSObject, MSAuthenticationProvider {

    // Implement singleton pattern
    static let instance = AuthenticationManager()

    private let publicClient: MSALPublicClientApplication?
    private let appId: String
    private let graphScopes: Array<String>

    private override init() {
        // Get app ID and scopes from AuthSettings.plist
        let bundle = Bundle.main
        let authConfigPath = bundle.path(forResource: "AuthSettings", ofType: "plist")!
        let authConfig = NSDictionary(contentsOfFile: authConfigPath)!

        self.appId = authConfig["AppId"] as! String
        self.graphScopes = authConfig["GraphScopes"] as! Array<String>

        do {
            // Create the MSAL client
            try self.publicClient = MSALPublicClientApplication(clientId: self.appId)
        } catch {
            print("Error creating MSAL public client: \(error)")
            self.publicClient = nil
        }
    }
    
    // Required function for the MSAuthenticationProvider interface
    func getAccessToken(for authProviderOptions: MSAuthenticationProviderOptions!, andCompletion completion: ((String?, Error?) -> Void)!) {
        getTokenSilently(completion: completion)
    }

    public func getTokenInteractively(parentView: UIViewController, completion: @escaping(_ accessToken: String?, Error?) -> Void) {
        let webParameters = MSALWebviewParameters(parentViewController: parentView)
        let interactiveParameters = MSALInteractiveTokenParameters(scopes: self.graphScopes,
                                                                   webviewParameters: webParameters)
        
        // Call acquireToken to open a browser so the user can sign in
        publicClient?.acquireToken(with: interactiveParameters, completionBlock: {
            (result: MSALResult?, error: Error?) in
            guard let tokenResult = result, error == nil else {
                print("Error getting token interactively: \(String(describing: error))")
                completion(nil, error)
                return
            }

            print("Got token interactively: \(tokenResult.accessToken)")
            completion(tokenResult.accessToken, nil)
        })
    }

    public func getTokenSilently(completion: @escaping(_ accessToken: String?, Error?) -> Void) {
        // Check if there is an account in the cache
        var userAccount: MSALAccount?

        do {
            userAccount = try publicClient?.allAccounts().first
        } catch {
            print("Error getting account: \(error)")
        }

        if (userAccount != nil) {
            // Attempt to get token silently
            let silentParameters = MSALSilentTokenParameters(scopes: self.graphScopes, account: userAccount!)
            publicClient?.acquireTokenSilent(with: silentParameters, completionBlock: {
                (result: MSALResult?, error: Error?) in
                guard let tokenResult = result, error == nil else {
                    print("Error getting token silently: \(String(describing: error))")
                    completion(nil, error)
                    return
                }

                print("Got token silently: \(tokenResult.accessToken)")
                completion(tokenResult.accessToken, nil)
            })
        } else {
            print("No account in cache")
            completion(nil, NSError(domain: "AuthenticationManager",
                                    code: MSALError.interactionRequired.rawValue, userInfo: nil))
        }
    }

    public func signOut() -> Void {
        do {
            // Remove all accounts from the cache
            let accounts = try publicClient?.allAccounts()

            try accounts!.forEach({
                (account: MSALAccount) in
                try publicClient?.remove(account)
            })
        } catch {
            print("Sign out error: \(String(describing: error))")
        }
    }
}
