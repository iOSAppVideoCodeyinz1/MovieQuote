//
//  MovieQuoteDetailViewController.swift
//  MovieQuote
//
//  Created by Theo Yin on 7/20/21.
//

import UIKit

class MovieQuoteDetailViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    
    var movieQuote: MovieQuote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(showEditDialog))
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
            self.movieQuote?.quote = quoteTextField.text!
            self.movieQuote?.movie = movieTextField.text!
            self.updateView()
        }
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateView()
    }
    
    func updateView(){
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
    }
}
