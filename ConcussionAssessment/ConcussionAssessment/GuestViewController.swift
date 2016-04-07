//
//  GuestViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 4/5/2016
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit
import CoreData

class GuestViewController: UITableViewController {
    
    let LabelArray = ["Take Full Diagnostic", "Take Individual Tests"]
    
    override func loadView() {
        super.loadView()
        
        self.title = "Guest"
    }
    
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Returns the number of elements to be made into cells in table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LabelArray.count
    }
    
    // Creates cells in table based on the number of items in LabelArray
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "GuestCell")
        
        Cell.textLabel?.text = LabelArray[indexPath.item]
        Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return Cell
    }
    
    
    // Configure the row selection code for any cells that you want to customize the row selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                // link FULL TEST PATH
                break;
            case 1:
                let IndividualController = IndividualTableViewController(style: UITableViewStyle.Grouped)
                currentScoreID = NSUUID().UUIDString
                database.insertNewScoreWithoutPlayer(currentScoreID!)
                self.navigationController?.pushViewController(IndividualController, animated: true)
                break;
            default:
                fatalError("Unknow Row");
            }
            break;
        default:
            fatalError("Unknown Section")
            break;
        }
    }
    
}