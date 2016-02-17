//
//  GlasgowVerbalTableViewController.swift
//  Concussion App 2.0
//
//  Created by Yvone Chau on 2/16/16.
//  Copyright © 2016 Kevin Fu. All rights reserved.
//

import UIKit


class GlasgowVerbalTableViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.editing = true
        
        self.navigationItem.title = "Glasgow"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .Plain, target: self.navigationController!, action: "popViewControllerAnimated:")
    }
    
      var data = ["No verbal response", "Incomprehensible sounds", "Inappropriate words ", "Confused", "Oriented" ]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VerbalCell", forIndexPath: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}