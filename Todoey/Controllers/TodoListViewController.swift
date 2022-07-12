//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    

    var itemArray = [Item]()
    var defaults = UserDefaults.standard
    let key = "TodoListItemArray"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        if let item = defaults.array(forKey: "TodoListItemArray") as? [String] {
//
//            itemArray = item
        
        let newItem1 = Item()
        newItem1 .title = "Find Mike"
        itemArray.append(newItem1)

        let newItem2 = Item()
        newItem2 .title = "Buy eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3 .title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        
       itemArray = defaults.array(forKey: key) as! [Item]
        
        
        
        }
        

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        if  itemArray[indexPath.row].done == true {
            itemArray[indexPath.row].done = false
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            itemArray[indexPath.row].done = true
            
        }
    }
//MARK: Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Todoey Items", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
            // What will happen when the user click on the Add Items button on our UIAlert
            print("Add Item")
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: self.key)
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
           
            print("now")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

