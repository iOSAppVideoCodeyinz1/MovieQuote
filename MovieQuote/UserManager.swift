//
//  UserManager.swift
//  MovieQuote
//
//  Created by Theo Yin on 8/16/21.
//

import Foundation
import Firebase
let kCollectionUsers = "Users"
let kKeyName = "name"
let kKeyPhotoUrl = "photoUrl"

class UserManager {
    var _collectionRef: CollectionReference
    var _document: DocumentSnapshot?
    var _userListener: ListenerRegistration?
    
    static let shared = UserManager()
    
    private init() {
        _collectionRef = Firestore.firestore().collection(kCollectionUsers)
    }
    
    
    //CRUD
    //Create
    func addNewUserMaybe(uid: String, name: String?, photoUrl: String?){
        //add user if not exist
        //add only not exist
        let userRef = _collectionRef.document(uid)
        userRef.getDocument { documentSnapshot, error in
            if let error = error {
                print("error getting error \(error)")
                return
            }
            if let documentSnapshot = documentSnapshot {
                if documentSnapshot.exists{
                    print("User exists, do nothing")
                    return
                } else {
                    print("Creating a new user with id \(uid)")
                    userRef.setData([
                        kKeyName: name ?? "",
                        kKeyPhotoUrl: photoUrl ?? ""
                    ])
                }
                
                
            }
            
            
            
        }
    }
    
    //Read
    func beginListening(uid: String, changeListener: () -> Void){
        
    }
    func stopListening(){
        _userListener?.remove()
    }
    
    //Update
    func updateName(name: String){
        
        
    }
    
    func updatePhoto(photoUrl: String){
        
        
    }
    //
    
    
    
    //Getters
    var name: String {
        get {
            if let value = _document?.get(kKeyName){
                return value as! String
            }
            return ""
        }
    }
    
    var photoUrl: String {
        get {
            if let value = _document?.get(kKeyPhotoUrl){
                return value as! String
            }
            return ""
        }
    }
}
