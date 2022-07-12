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
    let key = "storedArray"
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let newItem1 = Item()
        newItem1.name = "Find Mike"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.name = "Buy eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.name = "Demolish Demogorogon"
        itemArray.append(newItem3)
        
        if let storedArray = defaults.array(forKey: key) as? [Item] {
            itemArray = storedArray
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//MARK: Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
            // What will happen when the user click on the Add Items button on our UIAlert
            print("Add Item")
            let newItem = Item()
            newItem.name = textField.text!
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

