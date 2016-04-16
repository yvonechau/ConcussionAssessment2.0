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
    var cellMaxBounds: CGFloat = 0
    var CellDateField: UIDatePicker!
    let FormArray = [["First", "Last"], ["Gender", "Birthday"]]
    let SectionTitleArray = ["Name", "Details"]
    var newPlayer: [[String]] = []
    var didFinishEditingInformation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.title = "Create Profile"

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(self.finishedEditingProfile))
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
        /*if indexPath.section == 2 && indexPath.row == 1 {
            self.recordedResults += Cell.recordedResults
        }
        else {
            //let tempText: String? = Cell.CellTextField?.text
            //recordedResults.append(tempText!)
        }
        print(recordedResults)*/
        print(indexPath.row)
        if (indexPath.section == 1 && indexPath.row == 1) {
            Cell.CellTextField.userInteractionEnabled = false
            cellMaxBounds = 288
            setDateField()
        }
        return Cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionTitleArray[section]
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        for section in 0...1 {
            for row in 0...1 {
                let indexPath: NSIndexPath = NSIndexPath(forRow: row, inSection: section)
                let Cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomFormCell
                if textField.text == Cell.CellTextField.text && textField.text?.characters.count > 1 {
                    didFinishEditingInformation += 1
                }
            }
        }
        
    }
    
    func finishedEditingProfile() {
        
    }
    
    func dateChanged() {
        print("Entered dateChanged()")
        // handle date changes
        let indexPath: NSIndexPath = NSIndexPath(forRow: 1, inSection: 1)
        let Cell = self.tableView.cellForRowAtIndexPath(indexPath) as! CustomFormCell
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM - dd - yyyy"
        
        let birthdateString = dateFormatter.stringFromDate(CellDateField.date)
        print(birthdateString)
        
        Cell.CellTextField.text = birthdateString
    }
    
    func setDateField() {
        CellDateField = UIDatePicker(frame: CGRect(x: self.view.frame.minX, y: self.cellMaxBounds, width: self.view.frame.width, height: 200))
        CellDateField.backgroundColor = UIColor.whiteColor()
        
        let topBorder: CALayer = CALayer()
        topBorder.frame = CGRectMake(0, 0, CellDateField.frame.size.width, 1.0)
        topBorder.backgroundColor = UIColor.grayColor().CGColor
        CellDateField.layer.addSublayer(topBorder)
        
        CellDateField.addTarget(self, action: #selector(dateChanged), forControlEvents: UIControlEvents.ValueChanged)
        CellDateField.datePickerMode = UIDatePickerMode.Date
        CellDateField.maximumDate = NSDate()
            
        self.view.addSubview(CellDateField)
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
    
    init(style: UITableViewCellStyle, title: String, section: Int) {
        super.init(style: style, reuseIdentifier: "Cell")
        // move date stuff to the Controller
        // datePicker target self, action: function (smart one),, UIControlEventValueChanged
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        CellTextField = UITextField(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height))
        CellTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        CellTextField?.placeholder = title
        addSubview(CellTextField)
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
