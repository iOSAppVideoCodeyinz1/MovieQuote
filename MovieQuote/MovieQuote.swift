//
//  MovieQuote.swift
//  MovieQuote
//
//  Created by Theo Yin on 7/9/21.
//

import Foundation
import Firebase



class MovieQuote {
    var quote: String
    var movie: String
    var id: String?
    var author: String
    
//    init(quote: String, movie: String) {
//        self.quote = quote
//        self.movie = movie
//    }
    
    init(documentSnapShot: DocumentSnapshot) {
        self.id = documentSnapShot.documentID
        let data = documentSnapShot.data()!
        self.quote = data["quote"] as! String
        self.movie = data["movie"] as! String
        self.author = data["author"] as! String
    }
    
}

