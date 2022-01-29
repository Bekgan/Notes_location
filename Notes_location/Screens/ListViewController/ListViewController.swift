//
//  ListViewController.swift
//  Notes_location
//
//  Created by admin on 29/1/22.
//

import UIKit
import CoreData

class ListViewController: UITableViewController  {
    var tasks: [Tasks] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(onClickClearButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onClickSaveButton))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }
    
    func alert() {
        let alertController = UIAlertController(title: "add", message: "add", preferredStyle: .alert)
        let saveAlert = UIAlertAction(title: "add", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTask = tf?.text {
                self.saveTasks(newTask)
                self.tableView.reloadData()
            }
        }
        alertController.addTextField {_ in }
        let cencelAlert = UIAlertAction(title: "cencel", style: .default) { _ in }
        alertController.addAction(saveAlert)
        alertController.addAction(cencelAlert)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func saveTasks(_ title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else { return }
        let taskObject = Tasks(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            tasks.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleateTasks() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        if let tasks = try? context.fetch(fetchRequest) {
            for task in tasks {
                context.delete(task)
            }
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }
}

extension ListViewController {
    @objc func onClickClearButton() {
        deleateTasks()
    }
    
    @objc func onClickSaveButton() {
//        self.alert()
        let tasksViewController = TasksViewController()
        navigationController?.pushViewController(tasksViewController, animated: true)
    }
}




