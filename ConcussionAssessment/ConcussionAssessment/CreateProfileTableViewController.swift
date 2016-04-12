//
//  CreateProfileTableViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 4/5/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class CreateProfileTableViewController: UITableViewController, UITextFieldDelegate {
    
    let NumberOfSections = 3
    let FormArray = ["Name", "Birthday", "Team"]
    
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
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = CustomFormCell(style: UITableViewCellStyle.Value2, reuseIdentifier: "Cell")
        Cell.CellLabel?.text = FormArray[indexPath.row]
        
        return Cell
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
    
    init(frame: CGRect, title: String) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let LabelSize = self.frame.width / 6
        CellLabel = UILabel(frame: CGRectMake(self.frame.minX, 10, LabelSize, 40))
            
        CellTextField = UITextField(frame: CGRectMake(LabelSize, 5, 50, 30))
        
        addSubview(CellLabel)
        addSubview(CellTextField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}