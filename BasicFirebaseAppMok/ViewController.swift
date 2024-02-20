//
//  ViewController.swift
//  BasicFirebaseAppMok
//
//  Created by TYLER MOK on 2/14/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    
    var items = [String]()
    
    @IBOutlet weak var itemInputList: UITextField!
    
    @IBOutlet weak var itemAmountList: UITextField!
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        ref = Database.database().reference()
   
        ref.child("items").observe(.childAdded, with: { (snapshot) in
                 
            let n = snapshot.value as! String
                  
            if !self.items.contains(n){
            self.items.append(n)
                   }
               })
        
        ref.child("items").observeSingleEvent(of: .value, with: { snapshot in
    print("--inital load has completed and the last user was read--")
                    print(self.items)
                    })


    }

    
    @IBAction func addToListButton(_ sender: Any) {
        var item = itemInputList.text!
        var amount = "\(itemAmountList.text!)"
        ref.child("Items").childByAutoId().setValue(item)
        ref.child("Item Amount").childByAutoId().setValue(amount)
        
        print(item)
        print(amount)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
    
}

