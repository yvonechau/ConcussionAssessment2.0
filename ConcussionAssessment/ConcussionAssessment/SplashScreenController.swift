//
//  TableViewController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 2/22/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
var database: DataModel = DataModel(persistentStoreCoordinator: appDelegate.persistentStoreCoordinator, managedObjectContext: appDelegate.managedObjectContext)
var currentScoreID: String?
var currentPlayerID: String?

class SplashScreenController: UITableViewController {
    
    var performEvaluation: UITableViewCell = UITableViewCell()
    var reviewTestScores: UITableViewCell = UITableViewCell()

    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Splash Screen"
        
        self.performEvaluation.textLabel?.text = "Take Full Diagnostic"
        self.performEvaluation.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.performEvaluation.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.reviewTestScores.textLabel?.text = "View Player Profiles"
        self.reviewTestScores.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.reviewTestScores.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 2    // section 0 has 2 rows
        //case 1: return 1    // section 1 has 1 row
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
            case 0:
                switch(indexPath.row) {
                case 0: return self.performEvaluation   // section 0, row 0 is the first name
                case 1: return self.reviewTestScores    // section 0, row 1 is the last name
                    default: fatalError("Unknown row in section 0")
                }
            default: fatalError("Unknown section")
        }
    }
    
    // Configure the row selection code for any cells that you want to customize the row selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                let mc = MenuController(style: UITableViewStyle.Grouped)
                self.navigationController?.pushViewController(mc, animated:true)
                break;
            case 1:
                let lpp = ListPlayerProfileController(style: UITableViewStyle.Grouped)
                self.navigationController?.pushViewController(lpp, animated:true)
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