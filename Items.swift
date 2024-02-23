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
    
    //let dict = ["item": item, "amount": quan] as [String: Any]
    
    
    
}
