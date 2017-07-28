//
//  ViewController.swift
//  CoreDataPerson
//
//  Created by Nem Sothea on 7/28/17.
//  Copyright © 2017 Nem Sothea. All rights reserved.
//
//https://www.raywenderlich.com/145809/getting-started-core-data-tutorial
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableViewController: UITableView!
    
    var names:[String] = []
    
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
            self.names.append(nameTosave)
            self.tableViewController.reloadData()
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

 
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewController.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
}

