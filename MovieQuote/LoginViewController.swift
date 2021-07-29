//
//  LoginViewController.swift
//  MovieQuote
//
//  Created by Theo Yin on 7/29/21.
//

import UIKit
import Firebase
import Rosefire

class LoginViewController: UIViewController {
    let ShowListSegueIdentifier = "ShowListSegue"
    let REGISTRY_TOKEN = "5c56f2dd-a4c3-46d9-9ba2-aa2e3fb3a066"

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
    }
    
    @IBAction func pressedSignInNewUser(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating a new user for Email/Password \(error)")
                return
            }
            
            print("It worked, new user is created")
            print("Email is \(authResult!.user.email)")
            print("UID is \(authResult!.user.uid)")
            
            self.performSegue(withIdentifier: self.ShowListSegueIdentifier, sender: self)
            
            
        }
    }
    
    @IBAction func pressedLogInExistingUser(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error logging in an existing user for Email/Password \(error)")
                return
            }
            
            print("It worked, logged in an existion account")
            print("Email is \(authResult!.user.email)")
            print("UID is \(authResult!.user.uid)")
            
            self.performSegue(withIdentifier: self.ShowListSegueIdentifier, sender: self)
            
        }
    }
    
    @IBAction func pressedRosefireLogin(_ sender: Any) {
        Rosefire.sharedDelegate().uiDelegate = self // This should be your view controller
        Rosefire.sharedDelegate().signIn(registryToken: REGISTRY_TOKEN) { (err, result) in
          if let err = err {
            print("Rosefire sign in error! \(err)")
            return
          }
          print("Result = \(result!.token!)")
          print("Result = \(result!.username!)")
          print("Result = \(result!.name!)")
          print("Result = \(result!.email!)")
          print("Result = \(result!.group!)")
          Auth.auth().signIn(withCustomToken: result!.token) { (authResult, error) in
            if let error = error {
              print("Firebase sign in error! \(error)")
              return
            }
            // User is signed in using Firebase!
            self.performSegue(withIdentifier: self.ShowListSegueIdentifier, sender: self)
          }
        }

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            print("Someone is already signed in")
            self.performSegue(withIdentifier: self.ShowListSegueIdentifier, sender: self)
        }
        
    }
    
}
