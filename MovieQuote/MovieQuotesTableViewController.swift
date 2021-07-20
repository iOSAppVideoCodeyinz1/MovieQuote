//
//  MovieQuotesTableViewController.swift
//  MovieQuote
//
//  Created by Theo Yin on 7/9/21.
//

import UIKit

class MovieQuotesTableViewController: UITableViewController {
    let movieQuoteCellIndentifier = "MovieQuoteCell"
//    var names = ["Theo", "family member 1", "family member 2"]
    var movieQuotes = [MovieQuote]()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddQuoteDialog))
        
        movieQuotes.append(MovieQuote(quote: "I'll be back", movie: "The Terminator"))
        movieQuotes.append(MovieQuote(quote: "I am Groot", movie: "The Avengers"))
    }
    
    @objc func showAddQuoteDialog(){
        //todo: CRUD
        let alertController = UIAlertController(title: "Create a new Moive Quote", message: "", preferredStyle: UIAlertController.Style.alert)
     
        //configure
        
        alertController.addTextField { textfield in
            textfield.placeholder = "Quote"
        }
        
        alertController.addTextField { textfield in
            textfield.placeholder = "Movie"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let submitAction = UIAlertAction(title: "Create Quote", style: .default) { (action) in
            print("TODO: Create a Movie Quote")
            //TODO: Add a quote
            let quoteTextField = alertController.textFields![0] as UITextField
            let movieTextField = alertController.textFields![1] as UITextField
//            print(quoteTextField.text!)
//            print(movieTextField.text!)
            let newMovieQuote = MovieQuote(quote: quoteTextField.text!, movie: movieTextField.text!)
            self.movieQuotes.insert(newMovieQuote, at: 0)
            self.tableView.reloadData()
            
        }
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieQuotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieQuoteCellIndentifier, for: indexPath)
        
        
        //configure cell
//        cell.textLabel?.text = names[indexPath.row]
        cell.textLabel?.text = movieQuotes[indexPath.row].quote
        cell.detailTextLabel?.text = movieQuotes[indexPath.row].movie
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            print("Delete this quote")
            movieQuotes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
