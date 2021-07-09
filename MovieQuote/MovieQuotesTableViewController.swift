//
//  MovieQuotesTableViewController.swift
//  MovieQuote
//
//  Created by Theo Yin on 7/9/21.
//

import UIKit

class MovieQuotesTableViewController: UITableViewController {
    let movieQuoteCellIndentifier = "MovieQuoteCell"
    var names = ["Theo", "family member 1", "family member 2"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieQuoteCellIndentifier, for: indexPath)
        
        
        //configure cell
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
    
    
}
