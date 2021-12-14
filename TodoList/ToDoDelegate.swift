//
//  ToDoDelegate.swift
//  TodoList
//
//  Created by Mac on 09/05/1443 AH.
//

import Foundation


protocol ToDoDelegate {
   
    func addToDo(by controller: AddToDoViewController, with title: String, with note: String, with date: Date, at indexPath: NSIndexPath?)
    
}
