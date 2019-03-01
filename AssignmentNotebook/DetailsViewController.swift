//
//  DetailsViewController.swift
//  AssignmentNotebook
//
//  Created by Emmett Hasley on 2/28/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var assignLabel: UILabel!
    @IBOutlet weak var dueLabel: UILabel!
    let formatter = DateFormatter()
    var passedAssignment : Assignment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "MM/dd/yyyy"
        self.title = passedAssignment.classsss
        classLabel.text = passedAssignment.classsss
        assignLabel.text = passedAssignment.name
        dueLabel.text = formatter.string(from: passedAssignment.due)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
