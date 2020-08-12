//
//  DatabaseManager.swift
//  Lingo Chat
//
//  Created by Chetan on 2020-08-11.
//  Copyright © 2020 Chetan. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()    
}

//MARK: Transcation menthods implemented

extension DatabaseManager {
    
//    verification methods for account creation
    
///   verifies weather user account with same email exists
    public func userAccountExists(with email: String, completion: @escaping ((Bool) -> Void)) {

        database.child("Users").queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .childAdded) { (snapshot) in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    
//    insert methods
    
/// insert new user account user
    public func insertUser(with user: UserAccount) {
        guard let userID = FirebaseAuth.Auth.auth().currentUser?.uid else { return }
        database.child("Users").child(userID).setValue([
            "first-name": user.firstName,
            "last-name": user.lastName,
            "email": user.email
        ])
    }
    
    
//    update methods
    
    
//    deletion methods
}


struct UserAccount {
    let firstName: String
    let lastName: String
    let email: String
//    let profilePicUrl: URL
//    let userLanguage: String
}