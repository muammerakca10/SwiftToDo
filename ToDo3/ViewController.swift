//
//  ViewController.swift
//  ToDo3
//
//  Created by MAC on 16.08.2022.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var tasks = [String]()
    var ids = [UUID]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonTapped))
        
        getDatas()
    }
    
    @objc func addButtonTapped () {
        performSegue(withIdentifier: "toAddVC", sender: nil)
    }
    
    func getDatas(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context  = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let task = result.value(forKey: "taskValue") as? String {
                    tasks.append(task)
                }
                if let id = result.value(forKey: "id") as? UUID {
                    ids.append(id)
                }
                
            }
        } catch {
            print("Error when data getting")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }

}

