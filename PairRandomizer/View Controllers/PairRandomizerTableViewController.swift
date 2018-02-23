//
//  PairRandomizerTableViewController.swift
//  PairRandomizer
//
//  Created by Jaime Almanza on 23/02/18.
//  Copyright © 2018 Jaime Almanza. All rights reserved.
//

import UIKit

class PairRandomizerTableViewController: UITableViewController {
    
    
    // MARK: - Outlets and Actions
    
    @IBAction func randomizeButtonTapped(_ sender: UIBarButtonItem) {
        PersonController.shared.persons.shuffle()
        tableView.reloadData()
    }
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        presentAddNewPersonAlert()
    }
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Team \(section + 1)"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if PersonController.shared.persons.count % 2 == 0 {
            return PersonController.shared.persons.count / 2
        } else {
            return (PersonController.shared.persons.count / 2) + 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PersonController.shared.persons.count % 2 == 0 {
            return 2
        } else {
            if section == (tableView.numberOfSections - 1) {
                return 1
            } else {
                return 2
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let person = PersonController.shared.persons[indexOfCell(indexPath: indexPath)]
        // Configure the cell
        cell.textLabel?.text = person.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = PersonController.shared.persons[indexOfCell(indexPath: indexPath)]
            PersonController.shared.delete(person: person)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    // MARK: - Functions
    
    func presentAddNewPersonAlert() {
        let alertController = UIAlertController(title: "Add person", message: "Add a new person to the list to be randomized", preferredStyle: .alert)
        var newPersonTextField: UITextField?
        alertController.addTextField { (alertTextField) in
            alertTextField.placeholder = "Person's name"
            newPersonTextField = alertTextField
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let inputText = newPersonTextField?.text else { return }
            PersonController.shared.add(personWithName: inputText)
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func indexOfCell(indexPath: IndexPath) -> Int {
        return (indexPath.section * 2) + indexPath.row
    }
    
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdatePerson" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let person = PersonController.shared.persons[indexPath.row]
            let updatePersonVC = segue.destination as? PersonDetailViewController
            updatePersonVC?.person = person
        }
    }

}

extension Array {
    mutating func shuffle() {
        for _ in 0..<10 {
            sort {
                (_,_) in arc4random() < arc4random()
            }
        }
    }
}
