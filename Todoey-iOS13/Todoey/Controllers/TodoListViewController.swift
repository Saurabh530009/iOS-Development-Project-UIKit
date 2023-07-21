//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray: [Item] = []
    let defaults = UserDefaults.standard
    
//    = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        itemArray.append(Item(title: "Find Mike", done: false))
        itemArray.append(Item(title: "Buy Eggos", done: false))
        itemArray.append(Item(title: "Destory Demogorgon", done: false))
        
        if let item = (defaults.array(forKey: "TodoListArray") as? [Item]) {
            itemArray = item
        }
    }
    
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // Adding and removing checkmark by using Ternary Operator
        cell.accessoryType = item.done == true ? .checkmark: .none

        return cell
    }
    
    // MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIButton){
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once the user clicks the Add Item button on our UIAlert
//            print(textField.text ?? "Empty")
            self.itemArray.append(Item(title: textField.text!))
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("Success!")
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item"
//            print(alertTextField)
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
}

