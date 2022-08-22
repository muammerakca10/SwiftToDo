//
//  AddViewController.swift
//  ToDo3
//
//  Created by MAC on 18.08.2022.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    
    @IBOutlet var addTextView: UITextView!
    
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var taskLabel: UILabel!
    var newTask = ""
    
    var incomingTask = ""
    var incomingUUID : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextViewProperties(textView: addTextView)
        //Checks if it comes from the tableView or the add button
        if incomingTask != "" {
            addTextView.text = incomingTask
            addTextView.isOpaque = false
            addTextView.isEditable = false
            addTextView.layer.borderColor = UIColor.darkGray.cgColor
            taskLabel.text = "Task:"
            
            saveButton.isEnabled = false
        } else {
            addTextView.text = ""
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureForCloseKeyboard))
        
        view.addGestureRecognizer(gestureRecognizer)
        
        
    }
    //Text View properties
    func addTextViewProperties(textView: UITextView){
        
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 20.0
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.blue.cgColor
        textView.textAlignment = NSTextAlignment.left
        textView.dataDetectorTypes = .all
        textView.isEditable = true
    }
    //Gesture Recognizer for close keyboard
    @objc func gestureForCloseKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("Data_Saved"), object: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let task = NSEntityDescription.insertNewObject(forEntityName: "TaskEntity", into: context)
        
        //if textView is empty, dont save
        if addTextView.text != "" {
            task.setValue(addTextView.text, forKey: "taskValue")
            task.setValue(UUID(), forKey: "id")
            
            do{
                try context.save()
                print("kayit edildi")
            } catch {
                print("Save error")
            }
        } else {
            
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("dataSaved"), object: nil)
        
        self.navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true)
    }
    
}
