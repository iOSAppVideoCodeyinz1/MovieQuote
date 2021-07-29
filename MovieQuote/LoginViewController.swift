//
//  LoginViewController.swift
//  MovieQuote
//
//  Created by Theo Yin on 7/29/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    let ShowListSegueIdentifier = "ShowListSegue"
    
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
        print("todo: rosefire login in")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            print("Someone is already signed in")
            self.performSegue(withIdentifier: self.ShowListSegueIdentifier, sender: self)
        }
        
    }
    
}
