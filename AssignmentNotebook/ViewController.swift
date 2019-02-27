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
    var assignments : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let mathpages = "Math Pages 135-136"
        let paragraph = "Intro Paragraph"
        let assignmentNotebook = "Assignment Notebook App"
        assignments = [mathpages, paragraph, assignmentNotebook]
        tableView.reloadData()
        if let assignmentsssss = userDefaults.array(forKey: "List") {
            assignments = assignmentsssss as! [String]
            tableView.reloadData()
        } else {
            userDefaults.set(assignments, forKey: "List")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func whenAdded(_ sender: Any) {
        let alertController = UIAlertController(title: "Add An Item", message: "Use the text field to add your item", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            if alertController.textFields![0].text != "" {
                self.assignments.append(alertController.textFields![0].text!);
                self.tableView.reloadData()
                userDefaults.set(self.assignments, forKey: "List")
            }
        })
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        alertController.addTextField(configurationHandler: nil)
        present(alertController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Bear") {
            let currentAssignment = assignments[indexPath.row]
            cell.textLabel?.text = currentAssignment
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let alertController = UIAlertController(title: "Delete?", message: "Are you sure you want to delete \(self.assignments[indexPath.row])?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {action in
                self.assignments.remove(at: indexPath.row)
                self.tableView.reloadData()
                userDefaults.set(self.assignments, forKey: "List")
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


}

