//
//  ProfilePageViewController.swift
//  MovieQuote
//
//  Created by Theo Yin on 8/16/21.
//

import UIKit


class ProfilePageViewController: UIViewController {
    
    @IBOutlet weak var displayNameTextField: UITextField!

    @IBOutlet weak var profilePhotoImgView: UIImageView!
    
    @IBAction func pressedEditButton(_ sender: Any) {
        print("TODO: upload a photo")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNameTextField.addTarget(self, action: #selector(handleNameEdit), for: UIControl.Event.editingChanged)
    }
    
    @objc func handleNameEdit() {
        if let name = displayNameTextField.text{
            print("Send the name \(name) to Firestore")
        }
    }
}
