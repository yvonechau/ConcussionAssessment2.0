//
//  MenuController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 4/4/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MenuController: UITableViewController {
    
    
    var existingProfile: UITableViewCell = UITableViewCell()
    var createNewProfile: UITableViewCell = UITableViewCell()
    var proceedAsGuest: UITableViewCell = UITableViewCell()
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Menu Screen"
        
        
        self.existingProfile.textLabel?.text = "Select an Existing Profile"
        self.existingProfile.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.existingProfile.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.createNewProfile.textLabel?.text = "Create New Profile"
        self.createNewProfile.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.createNewProfile.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.proceedAsGuest.textLabel?.text = "Proceed as Guest"
        self.proceedAsGuest.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.proceedAsGuest.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
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
            case 0: return self.existingProfile
            case 1: return self.createNewProfile
            case 2: return self.proceedAsGuest
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
                let LPPController = ListPlayerProfileController(style: UITableViewStyle.Grouped)
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
    
    /*
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     switch indexPath.item {
     case 0:
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let vc = storyboard.instantiateViewControllerWithIdentifier("OrientationTestViewController")
     
     self.navigationController?.pushViewController(vc, animated: true)
     case 1:
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let vc = storyboard.instantiateViewControllerWithIdentifier("NumberTestViewController")
     
     self.navigationController?.pushViewController(vc, animated: true)
     default:
     print("Error")
     }
     }
     */
    
}