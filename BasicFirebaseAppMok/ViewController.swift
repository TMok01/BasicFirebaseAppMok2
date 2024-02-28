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
    var itms = [Items]()
    
    @IBOutlet weak var itemInputList: UITextField!
    
    @IBOutlet weak var itemAmountList: UITextField!
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        ref = Database.database().reference()
   
        ref.child("items").observe(.childAdded, with: { (snapshot) in
                 
            let n = snapshot.value as! [String: Any]
            var s = Items(dict: n)
            s.key = snapshot.key
            self.itms.append(s)
            self.tableViewOutlet.reloadData()
               })
        
        ref.child("items").observe(.childRemoved, with: { [self] (snapshot) in
            
            let n = snapshot.value as! [String: Any]
            
            var s = Items(dict: n)
            s.key = snapshot.key
            
            for i in 0..<itms.count {
                if(self.itms[i].key == snapshot.key) {
                    self.itms.remove(at: i)
                    self.tableViewOutlet.reloadData()
                    break
                }
            }
            
        })
        
        self.tableViewOutlet.reloadData()

    }

    
    @IBAction func addToListButton(_ sender: Any) {
        var itemInput = itemInputList.text!
        var amount = "\(itemAmountList.text!)"
        ref.child("Items").childByAutoId().setValue(itemInput)
        ref.child("Item Amount").childByAutoId().setValue(amount)
        
        var itemObj = Items(item: itemInputList.text!, quan: Int(itemAmountList.text!) ?? 0)
        itemObj.saveToFireBase()
        
        print(itemInput)
        print(amount)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = itms[indexPath.row].item
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itms[indexPath.row].deleteFromFireBase()
            itms.remove(at: indexPath.row)
            self.tableViewOutlet.reloadData()
        }
    }
    
    
    
}

