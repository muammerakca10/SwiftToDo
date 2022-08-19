//
//  AddViewController.swift
//  ToDo3
//
//  Created by MAC on 18.08.2022.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var addTextFieldText: UITextView!
    
    var newTask = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        addTextFieldText.layer.masksToBounds = true
        addTextFieldText.layer.cornerRadius = 20.0
        addTextFieldText.layer.borderWidth = 1
        addTextFieldText.layer.borderColor = UIColor.blue.cgColor
        addTextFieldText.textAlignment = NSTextAlignment.left
        addTextFieldText.dataDetectorTypes = .all
        addTextFieldText.isEditable = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureForCloseKeyboard))
        
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func gestureForCloseKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("Data_Saved"), object: nil)
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
