//
//  CreateProfileTableViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 4/5/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class CreateProfileTableViewController: UITableViewController, UITextFieldDelegate {
    
    let NumberOfSections = 2
    let FormArray = [["First", "Last"], ["Birthday", "Gender"]]
    let SectionTitleArray = ["Name", "Details"]
    var recordedResults: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.title = "Create Profile"

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(CreateProfileTableViewController.dismiss))
        self.navigationItem.rightBarButtonItem?.enabled = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return NumberOfSections
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FormArray[section].count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = CustomFormCell(style: UITableViewCellStyle.Value2, title: FormArray[indexPath.section][indexPath.row], section: indexPath.section)
        if indexPath.section == 2 && indexPath.row == 1 {
            self.recordedResults += Cell.recordedResults
        }
        else {
            //let tempText: String? = Cell.CellTextField?.text
            //recordedResults.append(tempText!)
        }
        print(recordedResults)
        return Cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionTitleArray[section]
    }
    
    func dismiss() {
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

}

class CustomFormCell: UITableViewCell {
    var CellTextField: UITextField!
    var CellDateField: UIDatePicker!
    var recordedResults: [String] = []
    
    init(style: UITableViewCellStyle, title: String, section: Int) {
        super.init(style: style, reuseIdentifier: "Cell")
        if title == "Birthday" {
            CellDateField = UIDatePicker()
            CellDateField.datePickerMode = UIDatePickerMode.Date
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            recordedResults.append(dateFormatter.stringFromDate(CellDateField.date))
            addSubview(CellDateField)
        } else {
            CellTextField = UITextField(frame: CGRectMake(self.frame.minX + 16, 0, self.frame.width - 32, self.frame.height))
            CellTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
            CellTextField?.placeholder = title
            addSubview(CellTextField)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //self.textLabel?.text = "Hello"
        //self.detailTextLabel?.text = "Welp"
    }
}
