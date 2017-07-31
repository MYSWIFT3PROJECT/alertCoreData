//
//  ViewController.swift
//  CoreDataPerson
//
//  Created by Nem Sothea on 7/28/17.
//  Copyright © 2017 Nem Sothea. All rights reserved.
//
//https://www.raywenderlich.com/145809/getting-started-core-data-tutorial
import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableViewController: UITableView!
    
    var names:[String] = []
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Person List"
        tableViewController.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
 
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Name", message: "add a new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            ACTION in
            guard let textField = alert.textFields?.first,
                let nameTosave = textField.text else {
                    return
            }
            self.save(name: nameTosave)
            self.tableViewController.reloadData()
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func save(name:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        //3
        person.setValue(name, forKey: "name")
        //4
        do {
            try managedContext.save()
            people.append(person)
        }catch let error as NSError {
            print("Could not save.\(error)\(error.userInfo)")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fectchRequest = NSFetchRequest<NSManagedObject> (entityName: "Person")
        do {
            people = try managedContext.fetch(fectchRequest)
        }catch let error as NSError {
            print("Could not fetch data.\(error)\(error.userInfo)")
        }
    }
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        let cell = tableViewController.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell
    }
    
}

