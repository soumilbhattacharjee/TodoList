//
//  DataManager.swift
//  TodoList
//
//  Created by Soumil on 26/10/19.
//  Copyright © 2019 Soumil. All rights reserved.
//

import UIKit
import CoreData

class DataManager {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /* Description: Add taskArray to DB
     - Parameter keys: No Parameter
     - Returns: No Parameter
     */
    func saveToDb() {
        do {
            try context.save()
        } catch {
            print(SAVING_ERROR_MESSAGE + "\(error)")
        }
    }
    
    /* Description: Add newTask to DB
     - Parameter keys: name, indexNo
     - Returns: Task
     */
    func createNewTask(with name: String, and indexNo: Int32) -> Task {
        let newTask = Task(context: context)
        newTask.name = name
        newTask.isDone = false
        newTask.indexNo = indexNo
        saveToDb()
        return newTask
    }
    
    /* Description: Retrive taskArray from DB
     - Parameter keys: No Parameter
     - Returns: [Task]?
     */
    func getDataFromDb() -> [Task]? {
        do {
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ENTITYNAME)
            let sortDescriptor = NSSortDescriptor(key: TASK.INDEXNO.rawValue, ascending: true)
            request.sortDescriptors = [sortDescriptor]
            return try context.fetch(request) as? [Task]
        } catch {
            print(FETCHING_ERROR_MESSAGE + "\(error)")
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
    func changeTaskOrder(from initialIndex: Int, to finalIndex: Int, within tasks: [Task]) {
        let startIndex = initialIndex < finalIndex ? initialIndex + 1 : initialIndex - 1
        let range = startIndex < finalIndex ? startIndex...finalIndex : finalIndex...startIndex
        for index in range {
            let task = tasks[index]
            task.indexNo = initialIndex < finalIndex ? Int32(task.indexNo - 1) : Int32(task.indexNo + 1)
        }
        let initialTask = tasks[initialIndex]
        initialTask.setValue(Int32(finalIndex), forKey: TASK.INDEXNO.rawValue)
        saveToDb()
    }
    
    /* Description: Retrive search result from DB
     - Parameter keys: searchKey
     - Returns: [Task]?
     */
    func getSearchResultFromDb(searchKey: String) -> [Task]? {
        do {
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ENTITYNAME)
            let predicate = NSPredicate(format: NAME_FILTER_QUERY, searchKey)
            let sortDescriptor = NSSortDescriptor(key: TASK.INDEXNO.rawValue, ascending: true)
            request.sortDescriptors = [sortDescriptor]
            request.predicate = predicate
            return try context.fetch(request) as? [Task]
        } catch {
            print(FETCHING_ERROR_MESSAGE + "\(error)")
            return nil
        }
    }
}
