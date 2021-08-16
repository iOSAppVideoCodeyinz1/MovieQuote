//
//  SideNavViewController.swift
//  MovieQuote
//
//  Created by Theo Yin on 8/16/21.
//

import UIKit
import Firebase
class SideNavViewController: UIViewController {
    
    @IBAction func pressedGoToProfile(_ sender: Any) {
        print("pressed profile")
        dismiss(animated: false, completion: nil)
        tableViewController.performSegue(withIdentifier: kProfilePageSegueId, sender: tableViewController)
    }
    
    @IBAction func pressedShowAllQuotes(_ sender: Any) {
        tableViewController.isShowingAll = true
        tableViewController.startListening()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedShowMyQuotes(_ sender: Any) {
        print("pressedShowMine")
   
        tableViewController.isShowingAll = false
        tableViewController.startListening()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedDelete(_ sender: Any) {
        print("pressedDelete")
        tableViewController.setEditing(!tableViewController.isEditing, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedLogOut(_ sender: Any) {
        print("pressedLogOut")
        do {
            try Auth.auth().signOut()
        } catch {
            print("sign out error")
        }
        dismiss(animated: true, completion: nil)
    }
    
    var tableViewController: MovieQuotesTableViewController {
            let navController = presentingViewController as! UINavigationController
            let tableViewController = navController.viewControllers.last as! MovieQuotesTableViewController
            return tableViewController
        
    }
}
