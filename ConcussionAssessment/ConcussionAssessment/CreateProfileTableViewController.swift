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
    let genderItems = ["Male", "Female", "Other"]
    let FormArray = [["First", "Last"], ["Team", "Gender", "ID # (optional)", "Pick birth date below", ""]]
    var FormArrayDataName = [String](count: 2, repeatedValue: "")
    var FormArrayDataInfo = [String](count: 4, repeatedValue: "")
    let SectionTitleArray = ["Name", "Details"]
    var newPlayer: [[String]] = []
    var didFinishEditingInformation = 0
    //var textInstructions: UILabel!
    var tap: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.title = "Create Profile"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(self.finishedEditingProfile))
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateProfileTableViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return NumberOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FormArray[section].count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = CustomFormCell(style: UITableViewCellStyle.Value2, title: FormArray[indexPath.section][indexPath.row], section: indexPath.section, tableFrame: tableView.frame)
        Cell.preservesSuperviewLayoutMargins = true
        Cell.contentView.preservesSuperviewLayoutMargins = true
        
        if (indexPath.section == 1 && (indexPath.row == 3 || indexPath.row == 1)) {
            Cell.CellTextField.userInteractionEnabled = false
        }
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            Cell.contentView.addSubview(setGenderField(tableView))
        }
        
        if (indexPath.section == 1 && indexPath.row == 4) {
            Cell.contentView.addSubview(setDateField(tableView))
        } else {
            Cell.CellTextField.delegate = self
            if indexPath.section == 0 {
                Cell.CellTextField.text = FormArrayDataName[indexPath.item]
            } else if indexPath.section == 1 {
                Cell.CellTextField.text = FormArrayDataInfo[indexPath.item]
            }
        }
        
        return Cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionTitleArray[section]
    }
    
    override func tableView(tableview: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 4 {
            return 200.0
        }
        return 44.0
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        view.endEditing(true)
        for section in 0...1 {
            if section == 1 {
                for row in 0...3 {
                    let indexPath: NSIndexPath = NSIndexPath(forRow: row, inSection: section)
                    let Cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomFormCell
                    if Cell.CellTextField.text?.characters.count > 0 {
                        didFinishEditingInformation += 1
                        FormArrayDataInfo[indexPath.item] = Cell.CellTextField.text!
                    } else if (row == 2) {
                        didFinishEditingInformation += 1
                    }
                }
            } else {
                for row in 0...1 {
                    let indexPath: NSIndexPath = NSIndexPath(forRow: row, inSection: section)
                    let Cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomFormCell
                    if Cell.CellTextField.text?.characters.count > 0 {
                        didFinishEditingInformation += 1
                        FormArrayDataName[indexPath.item] = Cell.CellTextField.text!
                        print(FormArrayDataName)
                    }
                }
            }
        }
        if didFinishEditingInformation == 6 {
            self.navigationItem.rightBarButtonItem?.enabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.enabled = false;
        }
        didFinishEditingInformation = 0
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.navigationItem.rightBarButtonItem?.enabled = false;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textFieldDidEndEditing(textField)
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setGenderField(tableView: UITableView) -> UISegmentedControl {
        let genderChoice = UISegmentedControl(items: self.genderItems)
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Pad:
            genderChoice.frame = CGRect(x: tableView.frame.maxX - 300 - 48, y: genderChoice.frame.maxY / 4, width: 300, height: 28)
        default:
            genderChoice.frame = CGRect(x: tableView.frame.maxX - 200 - 16, y: genderChoice.frame.maxY / 4, width: 200, height: 28)
        }
        
        genderChoice.addTarget(self, action: #selector(CreateProfileTableViewController.genderChoiceToText(_:)), forControlEvents: .ValueChanged)
        return genderChoice
    }
    
    func genderChoiceToText(sender: UISegmentedControl) {
        let indexPath: NSIndexPath = NSIndexPath(forRow: 1, inSection: 1)
        let Cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomFormCell
        
        switch sender.selectedSegmentIndex {
        case 0:
            Cell.CellTextField.text = "Male"
        case 1:
            Cell.CellTextField.text = "Female"
        case 2:
            Cell.CellTextField.text = "Other"
        default:
            Cell.CellTextField.text = "None"
        }
    }
    
    func finishedEditingProfile() {
        var trimmedTeam, trimmedGender, trimmedFirstName, trimmedLastName, trimmedIDNumber: String!
        var birthday: NSDate!
        var birthdayString: String!
        for section in 0...1 {
            if section == 1 {
                for row in 0...3 {
                    let indexPath: NSIndexPath = NSIndexPath(forRow: row, inSection: section)
                    let Cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomFormCell
                    switch(row) {
                    case 0:
                        let team = Cell.CellTextField.text!
                        trimmedTeam = team.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    case 1:
                        let gender = Cell.CellTextField.text!
                        trimmedGender = gender.stringByTrimmingCharactersInSet(
                            NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    case 2:
                        let idNumber = Cell.CellTextField.text!
                        trimmedIDNumber = idNumber.stringByTrimmingCharactersInSet(NSCharacterSet.decimalDigitCharacterSet())
                    case 3:
                        birthdayString = Cell.CellTextField.text!
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "MM-dd-yyyy"
                        birthday = dateFormatter.dateFromString(birthdayString)
                    default:
                        fatalError("Invalid row")
                    }
                }
            } else {
                for row in 0...1 {
                    let indexPath: NSIndexPath = NSIndexPath(forRow: row, inSection: section)
                    let Cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomFormCell
                    switch(row) {
                    case 0:
                        let firstName = Cell.CellTextField.text!
                        trimmedFirstName = firstName.stringByTrimmingCharactersInSet(
                            NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    case 1:
                        let lastName = Cell.CellTextField.text!
                        trimmedLastName = lastName.stringByTrimmingCharactersInSet(
                            NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    default:
                        fatalError("Invalid row")
                    }
                }
            }
        }
        
        print(trimmedFirstName + " " + trimmedLastName + " " + trimmedTeam + " " + trimmedGender + " " + birthdayString)
        
        let currentPlayerID = NSUUID().UUIDString
        database.insertNewPlayer(currentPlayerID)
        database.setFirstName(currentPlayerID, name: trimmedFirstName)
        database.setLastName(currentPlayerID, name: trimmedLastName)
        database.setBirthday(currentPlayerID, date: birthday)
        database.setGender(currentPlayerID, gender: trimmedGender)
        database.setTeamName(currentPlayerID, name: trimmedTeam)
        if trimmedIDNumber.characters.count > 0 {
            database.setIDNumber(currentPlayerID, studentID: trimmedIDNumber)
        }
        
        //print(database.playerWithID(currentPlayerID))
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func dateChanged() {
        // handle date changes
        let indexPath: NSIndexPath = NSIndexPath(forRow: 3, inSection: 1)
        let Cell = self.tableView.cellForRowAtIndexPath(indexPath) as! CustomFormCell
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM - dd - yyyy"
        
        let birthdateString = dateFormatter.stringFromDate(CellDateField.date)
        
        Cell.CellTextField.text = birthdateString
        Cell.CellTextField.textColor = UIColor(rgb: 0x007aff)
        textFieldDidEndEditing(Cell.CellTextField)
    }
    
    func setDateField(tableView: UITableView) -> UIDatePicker {
        CellDateField = UIDatePicker()
        CellDateField.backgroundColor = UIColor.whiteColor()
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Pad:
            CellDateField.frame = CGRect(x: tableView.frame.minX + 48, y: 0, width: tableView.frame.width - 96, height: 200)
        default:
            CellDateField.frame = CGRect(x: tableView.frame.minX + 16, y: 0, width: tableView.frame.width - 32, height: 200)
        }
        
        let tappedDateField = UITapGestureRecognizer(target: self, action: #selector(dateChanged))
        CellDateField.addTarget(self, action: #selector(dateChanged), forControlEvents: UIControlEvents.ValueChanged)
        CellDateField.datePickerMode = UIDatePickerMode.Date
        CellDateField.maximumDate = NSDate()
        CellDateField.addGestureRecognizer(tappedDateField)

        return CellDateField
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
     }*/
}

class CustomFormCell: UITableViewCell {
    var CellTextField: UITextField!
    
    init(style: UITableViewCellStyle, title: String, section: Int, tableFrame: CGRect) {
        super.init(style: style, reuseIdentifier: "Cell")
        // move date stuff to the Controller
        // datePicker target self, action: function (smart one),, UIControlEventValueChanged
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Pad:
            self.frame = CGRect(x: self.frame.minX + 48, y: self.frame.minY, width: self.frame.width - 96, height: self.frame.height)
        default:
            self.frame = CGRect(x: self.frame.minX + 16, y: self.frame.minY, width: self.frame.width - 32, height: self.frame.height)
        }
        
        if title != "" {
            CellTextField = UITextField(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: tableFrame.width, height: self.frame.height))
            switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Pad:
                CellTextField.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: tableFrame.width - 96, height: self.frame.height)
            default:
                CellTextField.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: tableFrame.width - 32, height: self.frame.height)
            }
            
            CellTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
            CellTextField.autocorrectionType = UITextAutocorrectionType.No
            CellTextField?.placeholder = title
            self.contentView.addSubview(CellTextField)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}