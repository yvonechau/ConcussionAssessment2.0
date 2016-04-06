//
//  TestScreenController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 4/4/16.
//  Copyright © 2016 PYKS. All rights reserved.
//


import Foundation
import UIKit
import CoreData

var testFlow = 0
// 0 individual tests
// 1 full examination

class TestScreenController: UITableViewController {
    
    
    var fullDiagnostic: UITableViewCell = UITableViewCell()
    var individualTests: UITableViewCell = UITableViewCell()
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "TestScreenController"
        
        
        self.fullDiagnostic.textLabel?.text = "Take Full Diagnostic"
        self.fullDiagnostic.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.fullDiagnostic.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.individualTests.textLabel?.text = "Take Individual Tests"
        self.individualTests.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.individualTests.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 2    // section 0 has 2 rows
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.fullDiagnostic   // section 0, row 0 is the first name
            case 1: return self.individualTests    // section 0, row 1 is the last name
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
                testFlow = 1;
                let SymptomView = SymptomViewController() as SymptomViewController
                self.navigationController?.pushViewController(SymptomView, animated: true)
                break;
            case 1:
                testFlow = 0;
                let IndividualTestsView = IndividualTableViewController(style: UITableViewStyle.Grouped)
                currentScoreID =  NSUUID().UUIDString
                database.insertNewScoreWithoutPlayer(currentScoreID!)
                self.navigationController?.pushViewController(IndividualTestsView, animated:true)
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