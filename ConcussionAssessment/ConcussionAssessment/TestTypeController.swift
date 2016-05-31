//
//  TestTypeController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 5/31/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import CoreData

class TestType: UITableViewController {
    
    
    var baseline: UITableViewCell = UITableViewCell()
    var newInjury: UITableViewCell = UITableViewCell()
    var postInjury: UITableViewCell = UITableViewCell()
    
    var currentPlayerID: String
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Select Type of Test"
        
        
        self.baseline.textLabel?.text = "Baseline Test"
        self.baseline.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.baseline.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.newInjury.textLabel?.text = "New Injury"
        self.newInjury.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.newInjury.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.postInjury.textLabel?.text = "Post-Injury Test"
        self.postInjury.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.postInjury.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
    }
    
    init(playerID: String) {
        currentPlayerID = playerID
        
        super.init(style: UITableViewStyle.Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 3
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.baseline
            case 1: return self.newInjury
            case 2: return self.postInjury
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
                let LPPController = ListPlayerProfileController(style: UITableViewStyle.Grouped, type: "Select", original: 1)
                self.navigationController?.pushViewController(LPPController, animated: true)
                break;
            case 1:
                let CNPController = CreateProfileTableViewController(style: UITableViewStyle.Grouped)
                self.navigationController?.pushViewController(CNPController, animated: true)
                break;
            case 2:
                let GVController = GuestViewController(style: UITableViewStyle.Grouped)
                self.navigationController?.pushViewController(GVController, animated: true)
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