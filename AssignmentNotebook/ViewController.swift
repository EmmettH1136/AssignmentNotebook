//
//  ViewController.swift
//  AssignmentNotebook
//
//  Created by Emmett Hasley on 2/25/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit
let userDefaults = UserDefaults.standard
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var assignments : [Assignment] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let mathpages = Assignment("Math Pages 135-136", "Math", "Monday 4")
        let paragraph = Assignment("Intro Paragraph", "World Lit", "Friday 1")
        let assignmentNotebook = Assignment("Assignment Notebook App", "Mobile Apps", "Tuesday 5")
        assignments = [mathpages, paragraph, assignmentNotebook]
        tableView.reloadData()
        if let object = UserDefaults.standard.data(forKey: "List") {
            if let objectDecoded = try? JSONDecoder().decode([Assignment].self, from: object) as [Assignment] {
                assignments = objectDecoded
            }
        } else {
            if let encoded = try? JSONEncoder().encode(assignments){
                UserDefaults.standard.set(encoded, forKey: "List")
            } else {
                print("Encoding Failed")
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func whenAdded(_ sender: Any) {
        let alertController = UIAlertController(title: "Add An Item", message: "Use the text field to add your item", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            if alertController.textFields![0].text != "" {
                self.assignments.append(Assignment(alertController.textFields![1].text!, alertController.textFields![0].text!, alertController.textFields![2].text!));
                self.tableView.reloadData()
                if let encoded = try? JSONEncoder().encode(self.assignments){
                    UserDefaults.standard.set(encoded, forKey: "List")
                } else {
                    print("Encoding Failed")
                }
            }
        })
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        alertController.addTextField { textField in
            textField.placeholder = "Class"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Assignment"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Due"
        }
        present(alertController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Bear") {
            let currentAssignment = assignments[indexPath.row]
            cell.textLabel?.text = currentAssignment.classsss
            cell.detailTextLabel?.text = currentAssignment.name + " " + currentAssignment.due
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let alertController = UIAlertController(title: "Delete?", message: "Are you sure you want to delete \(self.assignments[indexPath.row].name)?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {action in
                self.assignments.remove(at: indexPath.row)
                self.tableView.reloadData()
                if let encoded = try? JSONEncoder().encode(self.assignments){
                    UserDefaults.standard.set(encoded, forKey: "List")
                } else {
                    print("Encoding Failed")
                }
            })
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            self.present(alertController, animated: true, completion: nil)
            success(true)
        })
        modifyAction.title = "Delete"
        modifyAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! DetailsViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            let assignment = assignments[indexPath.row]
            nvc.passedAssignment = assignment
        }
    }

}

