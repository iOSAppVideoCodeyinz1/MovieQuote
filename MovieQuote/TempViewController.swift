//
//  TempViewController.swift
//  MovieQuote
//
//  Created by Theo Yin on 7/9/21.
//

import UIKit

class TempViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tempCelIdentifier = "TempCell"

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tempCelIdentifier, for: indexPath)
        cell.textLabel?.text = "This is row \(indexPath.row)"
        
        
        //configure the cell
        
        return cell
    }
    
    
    
}
