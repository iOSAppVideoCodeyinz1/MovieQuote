//
//  MovieQuoteDetailViewController.swift
//  MovieQuote
//
//  Created by Theo Yin on 7/20/21.
//

import UIKit
import Firebase

class MovieQuoteDetailViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    
    var movieQuote: MovieQuote?
    var movieQuoteRef: DocumentReference!
    var movieQuoteListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(showEditDialog))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        updateView()
        movieQuoteListener = movieQuoteRef.addSnapshotListener { documentSnapshot, error in
            if let error = error {
                print("Error getting the movie quote \(error)")
                return
            }
            if !documentSnapshot!.exists {
                print("might go back to the list since someone else delete this document")
                return
            }
            
            self.movieQuote = MovieQuote(documentSnapShot: documentSnapshot!)
            //decide whether we can edit or not
            if(Auth.auth().currentUser!.uid == self.movieQuote?.author){
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(self.showEditDialog))
            }else{
                self.navigationItem.rightBarButtonItem = nil    
            }
            
            
            
            self.updateView()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieQuoteListener.remove()
    }
    
    @objc func showEditDialog(){
        //todo: CRUD
        let alertController = UIAlertController(title: "Edit this Moive Quote", message: "", preferredStyle: UIAlertController.Style.alert)
        
        //configure
        
        alertController.addTextField { textfield in
            textfield.placeholder = "Quote"
            textfield.text = self.movieQuote?.quote
        }
        
        alertController.addTextField { textfield in
            textfield.placeholder = "Movie"
            textfield.text = self.movieQuote?.movie
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            //            print("TODO: Create a Movie Quote")
            //TODO: Add a quote
            let quoteTextField = alertController.textFields![0] as UITextField
            let movieTextField = alertController.textFields![1] as UITextField
            //            print(quoteTextField.text!)
            //            print(movieTextField.text!)
            //            let newMovieQuote = MovieQuote(quote: quoteTextField.text!, movie: movieTextField.text!)
//            self.movieQuote?.quote = quoteTextField.text!
//            self.movieQuote?.movie = movieTextField.text!
//            self.updateView()
            self.movieQuoteRef.updateData([
                "quote": quoteTextField.text!,
                "movie": movieTextField.text!
            ])
        }
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func updateView(){
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
    }
}
