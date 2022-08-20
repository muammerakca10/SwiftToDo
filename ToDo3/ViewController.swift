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
    
    var selectedTask = ""
    var selectedUUID : UUID?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonTapped))
        
        getDatas()
    }
    
    @objc func addButtonTapped () {
        selectedTask = ""
        performSegue(withIdentifier: "toAddVC", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getDatas), name: NSNotification.Name(rawValue: "dataSaved"), object: nil)
    }
    
    @objc func getDatas(){
        
        tasks.removeAll(keepingCapacity: false)
        ids.removeAll(keepingCapacity: false)
        
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
            tableView.reloadData()
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAddVC" {
            let destinationVC = segue.destination as! AddViewController
            destinationVC.incomingTask = selectedTask
            destinationVC.incomingUUID = selectedUUID
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTask = tasks[indexPath.row]
        selectedUUID = ids[indexPath.row]
        
        performSegue(withIdentifier: "toAddVC", sender: nil)
    }

}

