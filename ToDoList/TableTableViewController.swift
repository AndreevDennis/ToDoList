//
//  TableTableViewController.swift
//  ToDoList
//
//  Created by Denis Andreev on 5/20/19.
//  Copyright © 2019 353. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    
    let first = UIImage(named: "check")
    let second = UIImage(named: "uncheck")
    
    @IBAction func PushEdicAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder  = "New item name"
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
           return
            
        }
        let alertAction2 = UIAlertAction(title: "Create", style: .default) { (alert) in
            var newItem =  alertController.textFields![0].text
            if newItem == "" {
                newItem  = "New Item"
            }
            addItem(nameItem: newItem!)
            self.tableView.reloadData()
            
            
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.groupTableViewBackground
    }
    
    
    //Choose number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Choose number of row in sections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    // Fill cells for datas
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentItem = toDoItems[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        if  (currentItem["isCompleted"] as? Bool) == true {
//            cell.accessoryType = .checkmark
            cell.imageView?.image = first
        }else{
            cell.imageView?.image = second
        }
        return cell
    }
    
    // allow doing some moves like deleting or insert (return true or false)
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    // Edit cells for deleting or insert
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if changeState(at: indexPath.row){
           tableView.cellForRow(at: indexPath)?.imageView?.image = first
        } else {
             tableView.cellForRow(at: indexPath)?.imageView?.image = second
        }
    }
    
    
    // when you push one objet to another place
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
       
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
     }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
