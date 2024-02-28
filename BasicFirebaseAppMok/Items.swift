//
//  Items.swift
//  BasicFirebaseAppMok
//
//  Created by TYLER MOK on 2/20/24.
//

import Foundation
import FirebaseDatabase
import FirebaseCore

public class Items {
    
var item: String = ""
var quan: Int
var ref = Database.database().reference()
var key = ""
    
    
    init(item: String, quan: Int) {
        self.item = item
        self.quan = quan
    }
    
    init(dict:[String: Any]) {
        if let a = dict["quan"] as? Int {
            quan = a
        }
        else {
            quan = 0
        }
        
        if let b = dict["item"] as? String {
            item = b
        }
        else {
            item = ""
        }
    }
    
    
    func saveToFireBase() {
        let dict = ["item": item, "amount": quan] as [String: Any]
        ref.child("items").childByAutoId().setValue(dict)
    }
    
    func deleteFromFireBase() {
        ref.child("items").child(key).removeValue()
    }
}
