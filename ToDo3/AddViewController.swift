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
    
    var newTask = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureForCloseKeyboard))
        
        view.addGestureRecognizer(gestureRecognizer)
        
        addTextViewProperties(textView: addTextView)
    }
    
    func addTextViewProperties(textView: UITextView){
        
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 20.0
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.blue.cgColor
        textView.textAlignment = NSTextAlignment.left
        textView.dataDetectorTypes = .all
        textView.isEditable = true
    }
    
    @objc func gestureForCloseKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("Data_Saved"), object: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let task = NSEntityDescription.insertNewObject(forEntityName: "TaskEntity", into: context)
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
