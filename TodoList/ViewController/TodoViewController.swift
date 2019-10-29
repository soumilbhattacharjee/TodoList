//
//  TodoViewController.swift
//  TodoList
//
//  Created by Soumil on 26/10/19.
//  Copyright © 2019 OIT. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    let viewModel = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        viewModel.getDataFromDb()
    }
    
    // MARK: - Table view data source methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taskArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        let task = viewModel.taskArray[indexPath.row]
        cell.textLabel?.text = task.name
        cell.accessoryType = task.isDone ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.updateTaskStatus(index: indexPath.row)
        tableView.cellForRow(at: indexPath)?.accessoryType = viewModel.taskArray[indexPath.row].isDone ? .checkmark : .none
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.changeTaskOrder(from: sourceIndexPath.row, to: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            viewModel.deleteTasks(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    /* Description: Add button action
     - Parameter keys: sender
     - Returns: No Parameter
     */
    @IBAction func addNewTaskAction(_ sender: UIBarButtonItem) {
        showTaskEntryView()
    }
    
    /* Description: Turns table editing option on/ Off
     - Parameter keys: sender
     - Returns: No Parameter
     */
    @IBAction func reorderTasksAction(_ sender: UIBarButtonItem) {
        if sender.title == "Reorder" {
            tableView.isEditing = true
            sender.title = "Done"
        } else {
            tableView.isEditing = false
            sender.title = "Reorder"
        }
    }
    
    /* Description: Show custom alert to add new task
     - Parameter keys: No Parameter
     - Returns: No Parameter
     */
    func showTaskEntryView() {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Task", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textfield = textField
        }
        let alertAction = UIAlertAction(title: "Add", style: .default) { (addTask) in
            if let text = textfield.text, text != "" {
                if self.viewModel.addNewTaskToArray(newTaskName: text) {
                    self.showAlertView(name: "Success", description: "New Task entry successful!!")
                } else {
                    self.showAlertView(name: "Error", description: "Task already exists. Please try again!!")
                }
            self.tableView.reloadData()
            }
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    /* Description: Show alert message
     - Parameter keys: name, description
     - Returns: No Parameter
     */
    func showAlertView(name: String, description: String) {
        let alert = UIAlertController(title: name, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
