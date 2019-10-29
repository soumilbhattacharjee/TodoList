//
//  TodoViewModel.swift
//  TodoList
//
//  Created by Soumil on 26/10/19.
//  Copyright © 2019 Soumil. All rights reserved.
//

import UIKit
import CoreData

class TodoViewModel {
    var taskArray = [Task]()
    let dataModel = DataManager()
    
    /* Description: Add newTask to local Array
     - Parameter keys: newTaskName
     - Returns: Bool
     */
    func addNewTaskToArray(newTaskName: String) -> Bool {
        if checkIfTaskExists(name: newTaskName) {
            let newTask = dataModel.createNewTask(with: newTaskName, and: Int32(taskArray.count))
            taskArray.append(newTask)
            return true
        }
        return false
    }
    
    /* Description: update Task Status
     - Parameter keys: index
     - Returns: No Parameter
     */
    func updateTaskStatus(index: Int) {
        taskArray[index].isDone = !taskArray[index].isDone
        dataModel.saveToDb()
    }
    
    /* Description: Add taskArray to DB
     - Parameter keys: No Parameter
     - Returns: No Parameter
     */
    func saveToDb() {
        dataModel.saveToDb()
    }
    
    /* Description: Retrive taskArray from DB
     - Parameter keys: No Parameter
     - Returns: No Parameter
     */
    func getDataFromDb() {
        guard let tasks = dataModel.getDataFromDb() else {return}
        taskArray = tasks
    }
    
    /* Description: Delete task from DB
     - Parameter keys: index
     - Returns: No Parameter
     */
    func deleteTasks(at index: Int) {
        dataModel.deleteTasks(task: taskArray[index])
        taskArray.remove(at: index)
    }
    
    /* Description: Change The order of the task
     - Parameter keys: initialIndex, finalIndex
     - Returns: No Parameter
     */
    func changeTaskOrder(from initialIndex: Int, to finalIndex: Int) {
        let task = taskArray[initialIndex]
        dataModel.changeTaskOrder(from: initialIndex, to: finalIndex, within: taskArray)
        taskArray.remove(at: initialIndex)
        taskArray.insert(task, at: finalIndex)
    }
    
    /* Description: Checking if the same task exists
     - Parameter keys: name
     - Returns: Bool
     */
    func checkIfTaskExists(name: String) -> Bool {
        let task = taskArray.filter { (task) -> Bool in
            task.name == name
        }
        return task.isEmpty ? true : false
    }
}
