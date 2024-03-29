//
//  Constants.swift
//  TodoList
//
//  Created by Soumil on 29/10/19.
//  Copyright © 2019 Soumil. All rights reserved.
//

import Foundation

// all constants of the project

let CELL_IDENTIFIRE = "customCell"
let REORDER_BUTTON_TITLE = "Reorder"
let DONE_BUTTON_TITLE = "Done"
let ADD_TASK_ALERT_TITLE = "Add New Task"
let ALERT_CREATE_TASK_BUTTON_TITLE = "Add"
let ADD_TASK_SUCCESS_TITLE = "SUCCESS"
let ADD_TASK_SUCCESS_MESSAGE = "New Task entry successful!!"
let ADD_TASK_FAILURE_TITLE = "FAILED"
let ADD_TASK_FAILURE_MESSAGE = "Task already exists. Please try again!!"
let ALERT_ACTION_TITLE = "OK"
let ALERT_CANCEL_ACTION_BUTTON_TITLE = "CANCEL"
let SEARCHBAR_PLACEHOLDER = "Search Tasks"

// All database related constants

let ENTITYNAME = "Task"
enum TASK: String {
    case NAME = "name"
    case ISDONE = "isDone"
    case INDEXNO = "indexNo"
}
let SAVING_ERROR_MESSAGE = "Saving Error: "
let FETCHING_ERROR_MESSAGE = "Fetching Error: "
/// Case sensitivity in filter quries
///
/// [c] case insensitive: lowercase & uppercase values are treated the same
///
/// [d] diacritic insensitive: special characters treated as the base character
let NAME_FILTER_QUERY = "name CONTAINS[c] %@"
