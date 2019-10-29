//
//  TodoViewController.swift
//  TodoList
//
//  Created by Soumil on 26/10/19.
//  Copyright © 2019 Soumil. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    let viewModel = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        viewModel.getDataFromDb()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    // MARK: - Table view data source methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taskArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIRE, for: indexPath)
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
    
    //MARK:- Button actions
    
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
        if sender.title == REORDER_BUTTON_TITLE {
            tableView.isEditing = true
            sender.title = DONE_BUTTON_TITLE
        } else {
            tableView.isEditing = false
            sender.title = REORDER_BUTTON_TITLE
        }
    }
    
    //MARK:- Alert View actions
    
    /* Description: Show custom alert to add new task
     - Parameter keys: No Parameter
     - Returns: No Parameter
     */
    func showTaskEntryView() {
        var textfield = UITextField()
        let alert = UIAlertController(title: ADD_TASK_ALERT_TITLE, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textfield = textField
        }
        let createAlertAction = UIAlertAction(title: ALERT_CREATE_TASK_BUTTON_TITLE, style: .default) { (addTask) in
            if let text = textfield.text, !text.isEmpty {
                if self.viewModel.addNewTaskToArray(newTaskName: text) {
                    self.showAlertView(name: ADD_TASK_SUCCESS_TITLE, description: ADD_TASK_SUCCESS_MESSAGE)
                } else {
                    self.showAlertView(name: ADD_TASK_FAILURE_TITLE, description: ADD_TASK_FAILURE_MESSAGE)
                }
            self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: ALERT_CANCEL_ACTION_BUTTON_TITLE, style: .destructive, handler: nil)
        alert.addAction(createAlertAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    /* Description: Show alert message
     - Parameter keys: name, description
     - Returns: No Parameter
     */
    func showAlertView(name: String, description: String) {
        let alert = UIAlertController(title: name, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: ALERT_ACTION_TITLE, style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
