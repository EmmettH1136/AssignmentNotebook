//
//  AddViewController.swift
//  AssignmentNotebook
//
//  Created by Emmett Hasley on 2/28/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var assignTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    let formatter = DateFormatter()
    var passedArray : [Assignment] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        formatter.dateFormat = "MM/dd/yyyy"

        // Do any additional setup after loading the view.
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
//        txtDatePicker.inputAccessoryView = toolbar
//        txtDatePicker.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
//        txtDatePicker.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

//    let alertController = UIAlertController(title: "Add An Item", message: "Use the text field to add your item", preferredStyle: .alert)
//    let yesAction = UIAlertAction(title: "OK", style: .default, handler: { action in
//        if alertController.textFields![0].text != "" {
//            self.assignments.append(Assignment(alertController.textFields![1].text!, alertController.textFields![0].text!, alertController.textFields![2].text!));
//            self.tableView.reloadData()
//            if let encoded = try? JSONEncoder().encode(self.assignments){
//                UserDefaults.standard.set(encoded, forKey: "List")
//            } else {
//                print("Encoding Failed")
//            }
//        }
//    })
//    let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
//    alertController.addAction(yesAction)
//    alertController.addAction(noAction)
//    alertController.addTextField { textField in
//    textField.placeholder = "Class"
//    }
//    alertController.addTextField { textField in
//    textField.placeholder = "Assignment"
//    }
//    alertController.addTextField { textField in
//    textField.placeholder = "Due"
//    }
//    present(alertController, animated: true, completion: nil)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let _ = segue.destination as! ViewController
        if let currentClass = classTextField.text {
            if let currentAssignment = assignTextField.text {
                if let currentDate = formatter.date(from: formatter.string(from: datePicker.date)) {
                    passedArray.append(Assignment(currentAssignment, currentClass, currentDate))
                    if let encoded = try? JSONEncoder().encode(self.passedArray){
                        UserDefaults.standard.set(encoded, forKey: "List")
                    } else {
                        print("Encoding Failed")
                    }
                }
            }
        }
    }

}
