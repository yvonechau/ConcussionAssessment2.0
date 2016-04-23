//
//  ListPlayerProfilesController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation 
import UIKit

class ListPlayerProfileController: UITableViewController {
    
    var player1: UITableViewCell = UITableViewCell()
    var player2: UITableViewCell = UITableViewCell()
    var player3: UITableViewCell = UITableViewCell()
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Profiles"
        
        
        self.player1.textLabel?.text = "John Smith"
        self.player1.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.player1.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.player2.textLabel?.text = "Jane Doe"
        self.player2.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.player2.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.player3.textLabel?.text = "Apple Martin"
        self.player3.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.player3.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 3    // section 0 has 2 rows
            //case 1: return 1    // section 1 has 1 row
        default: fatalError("Unknown number of sections")
        }
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {    // Return the row for the corresponding section and row
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                let PlayerProfileSelection = PlayerProfileViewController(name: "John Smith", playerID: 12345) as PlayerProfileViewController
                self.navigationController?.pushViewController(PlayerProfileSelection, animated: true)
            case 1:
                let PlayerProfileSelection = PlayerProfileViewController(name: "Jane Doe", playerID: 12345) as PlayerProfileViewController
                self.navigationController?.pushViewController(PlayerProfileSelection, animated: true)
            case 2:
                let PlayerProfileSelection = PlayerProfileViewController(name: "Apple Martin", playerID: 12345) as PlayerProfileViewController
                self.navigationController?.pushViewController(PlayerProfileSelection, animated: true)
            default:
                fatalError("Invalid row")
            }
        default:
            fatalError("Invalid section")
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.player1   // section 0, row 0 is the first name
            case 1: return self.player2   // section 0, row 1 is the last name
            case 2: return self.player3
            default: fatalError("Unknown row in section 0")
            }
        default: fatalError("Unknown section")
        }
    }
}


