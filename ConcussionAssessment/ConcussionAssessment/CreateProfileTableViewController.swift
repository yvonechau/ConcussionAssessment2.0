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
    let FormArray = [["Name"], ["Birthday", "Date Created"]]
    let SectionTitleArray = ["Basic Information", "Details"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.title = "Create Profile"

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(CreateProfileTableViewController.dismiss))
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
    var CellLabel: UILabel!
    
    init(style: UITableViewCellStyle, title: String, section: Int) {
        super.init(style: style, reuseIdentifier: "Cell")
        var LabelSize: CGFloat
        if section != 1 {
            LabelSize = self.frame.width / 6
        }
        else {
            LabelSize = self.frame.width / 3
        }
        
        CellLabel = UILabel(frame: CGRectMake(self.frame.minX + 15, 0, LabelSize, 44))
        CellLabel?.numberOfLines = 0
        CellLabel?.text = title
        
        CellTextField = UITextField(frame: CGRectMake(LabelSize + 15, 0, LabelSize * 5, 44))
        
        addSubview(CellLabel)
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
