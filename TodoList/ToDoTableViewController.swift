//
//  ViewController.swift
//  TodoList
//
//  Created by Mac on 09/05/1443 AH.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController, ToDoDelegate  {

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tasks = [ToDoEntity]()
    var checked = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        fetchAllItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell
        
        cell.taskTitle.text = tasks[indexPath.row].title
        cell.taskNote.text = tasks[indexPath.row].note
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: tasks[indexPath.row].date!)
        cell.taskDeadline.text = dateString
   
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let item = tasks[indexPath.row]
            managedObjectContext.delete(item)
                    
                    do {
                        try managedObjectContext.save()
                       
                    }catch{
                        print(error.localizedDescription)
                    }
            tasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
                   if cell.accessoryType == .checkmark {
                       cell.accessoryType = .none
                   } else {
                       cell.accessoryType = .checkmark
                   }
               }
               tableView.deselectRow(at: indexPath, animated: true)
           }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let addItemTableController = segue.destination as! AddToDoViewController
        addItemTableController.delegate = self
    }
    
    func fetchAllItems(){
        
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoEntity")
        do {
            let results = try managedObjectContext.fetch(itemRequest)
            tasks = results as! [ToDoEntity]
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    func addToDo(by controller: AddToDoViewController, with title: String, with note: String, with date: Date, at indexPath: NSIndexPath?) {
       
        let thing = NSEntityDescription.insertNewObject(forEntityName: "ToDoEntity", into: managedObjectContext) as! ToDoEntity
        
        thing.title = title
        thing.note = note
        thing.date = date
     
        tasks.append(thing)
       
    if managedObjectContext.hasChanges{
        do {
            try managedObjectContext.save()
           
           
        }catch{
            print(error.localizedDescription)
          
        }
    }

    tableView.reloadData()
    dismiss(animated: true, completion: nil)

    }
    
}

