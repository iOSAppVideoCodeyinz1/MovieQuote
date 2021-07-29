//
//  MovieQuotesTableViewController.swift
//  MovieQuote
//
//  Created by Theo Yin on 7/9/21.
//

import UIKit
import Firebase

class MovieQuotesTableViewController: UITableViewController {
    let movieQuoteCellIndentifier = "MovieQuoteCell"
    //    var names = ["Theo", "family member 1", "family member 2"]
    var movieQuotes = [MovieQuote]()
    let detailSegueIndentifier = "DetailSegue"
    var movieQuotesRef: CollectionReference!
    var movieQuoteListener: ListenerRegistration!
    var isShowingAll = true
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu))
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddQuoteDialog))
        
        //        movieQuotes.append(MovieQuote(quote: "I'll be back", movie: "The Terminator"))
        //        movieQuotes.append(MovieQuote(quote: "I am Groot", movie: "The Avengers"))
        movieQuotesRef = Firestore.firestore().collection("MovieQuotes")
    }
    
    @objc func showMenu (){

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //configure
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let createAction = UIAlertAction(title: "Create Quote", style: .default) { (action) in
            self.showAddQuoteDialog()
        }
        let showMyAction = UIAlertAction(title: self.isShowingAll ? "Show only my quotes" : "Show all quotes", style: .default) { (action) in
            //toggle the show all/mine mode
            self.isShowingAll = !self.isShowingAll
            //update the list
            self.startListening()
        }
        
        alertController.addAction(showMyAction)
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if (Auth.auth().currentUser == nil){
//            //you are NOT signed in
//            print("Signed in")
//            Auth.auth().signInAnonymously { authResult, error in
//                if let error = error {
//                    print("Error with anonymous auth \(error)")
//                    return
//                }
//                print("You are signed in. Well Done!")
//            }
//        }else {
//            //you are signed in
//            print("You are already signed in.")
//        }
        
        //temp sign out
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            print("Sign out error")
//        }
        
        
        if(Auth.auth().currentUser == nil){
            print("you messed up, go back to login page")
        }else {
            print("you've signed in!")
        }
//        tableView.reloadData()
        startListening()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieQuoteListener.remove()
    }
    
    func startListening() {
        if(movieQuoteListener != nil) {
            movieQuoteListener.remove()
        }
        var query = movieQuotesRef.order(by: "created", descending: true).limit(to: 50)
        
        if(!isShowingAll){
            query = query.whereField("author", isEqualTo: Auth.auth().currentUser!.uid)
        }
        
        movieQuoteListener = query.addSnapshotListener { querySnapshot, error in
            if querySnapshot != nil {
                self.movieQuotes.removeAll()
                querySnapshot?.documents.forEach({ documentSnapshot in
                    //                    print(documentSnapshot.documentID)
                    //                    print(documentSnapshot.data())
                    self.movieQuotes.append(MovieQuote(documentSnapShot: documentSnapshot))
                    self.tableView.reloadData()
                })
            } else {
                print("Error getting movie quotes \(error!)")
            }
        }
    }
    
    func showAddQuoteDialog(){
//        //todo: CRUD
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
            //            let newMovieQuote = MovieQuote(quote: quoteTextField.text!, movie: movieTextField.text!)
            //            self.movieQuotes.insert(newMovieQuote, at: 0)
            //            self.tableView.reloadData()
            self.movieQuotesRef.addDocument(data: [
                "quote": quoteTextField.text,
                "movie": movieTextField.text,
                "created": Timestamp.init(),
                "author": Auth.auth().currentUser!.uid
            ])

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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let movieQuote = movieQuotes[indexPath.row]
        return Auth.auth().currentUser!.uid == movieQuote.author
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            print("Delete this quote")
            //            movieQuotes.remove(at: indexPath.row)
            //            tableView.reloadData()
            let movieQuoteToDelete = movieQuotes[indexPath.row]
            movieQuotesRef.document(movieQuoteToDelete.id!).delete()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        print("prepare")
        //        print(segue.identifier == detailSegueIndentifier)
        if segue.identifier == detailSegueIndentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
//                (segue.destination as! MovieQuoteDetailViewController).movieQuote = movieQuotes[indexPath.row]
                (segue.destination as! MovieQuoteDetailViewController).movieQuoteRef = movieQuotesRef.document(movieQuotes[indexPath.row].id!)

            }
        }
    }
}
