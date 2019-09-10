//
//  ViewController.swift
//  Todoey
//
//  Created by Oliver Weinmeier on 04.09.19.
//  Copyright © 2019 oliverweinmeier. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let newItem = Item()
        newItem.title = "Finish C Course"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Finish iOS App Dev Course"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Finish Namjai/Jaithai Webpage"
        itemArray.append(newItem3)
        
        //if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        //    itemArray = items
        //}
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (itemArray.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //User clicked add item button on UI Alert
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
            }
            catch {
                print("Error encoding item array, \(error)")
            }
            
            self.tableView.reloadData()
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            //print(alertTextField.text)
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    

}

