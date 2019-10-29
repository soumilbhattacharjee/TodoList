//
//  DataManager.swift
//  TodoList
//
//  Created by Soumil on 26/10/19.
//  Copyright © 2019 OIT. All rights reserved.
//

import UIKit
import CoreData

class DataManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /* Description: Add taskArray to DB
     - Parameter keys: No Parameter
     - Returns: No Parameter
     */
    func saveToDb() {
        // Add db save method
        do {
            try context.save()
        } catch {
            print("Saving Error \(error)")
        }
    }
    
    /* Description: Retrive taskArray from DB
     - Parameter keys: No Parameter
     - Returns: [Task]?
     */
    func getDataFromDb() -> [Task]? {
        // Add db retrive method
        do {
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Task")
            let sortDescriptor = NSSortDescriptor(key: "indexNo", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            return try context.fetch(request) as? [Task]
        } catch {
            print("Fetching Error \(error)")
            return nil
        }
    }
    
    /* Description: Delete task from DB
     - Parameter keys: task
     - Returns: No Parameter
     */
    func deleteTasks(task: Task) {
        context.delete(task)
        saveToDb()
    }
    
    /* Description: Change The order of the task
     - Parameter keys: initialTask, finalTask
     - Returns: No Parameter
     */
    func changeTaskOrder(from initialTask: Task, to finalTask: Task) {
        let tempindex = initialTask.indexNo
        initialTask.setValue(finalTask.indexNo, forKey: "indexNo")
        finalTask.setValue(tempindex, forKey: "indexNo")
        saveToDb()
    }
}
