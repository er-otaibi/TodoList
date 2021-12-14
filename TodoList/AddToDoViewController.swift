//
//  AddToDoViewController.swift
//  TodoList
//
//  Created by Mac on 09/05/1443 AH.
//

import UIKit

class AddToDoViewController: UIViewController {

    var delegate: ToDoDelegate?
    
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddItemButton(_ sender: UIButton) {
        
        guard let title = titleTextField.text else {return}
        guard let note = noteTextView.text else {return}
        
    
      
        delegate?.addToDo(by: self, with: title, with: note, with: dateTimePicker.date, at: indexPath)
        dismiss(animated: true, completion: nil)

    }
    
}


