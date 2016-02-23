//
//  CognitiveTableViewController.swift
//  Concussion App 2.0
//
//  Created by Philson Wong on 2/16/16.
//  Copyright © 2016 Kevin Fu. All rights reserved.
//

import UIKit

class CognitiveTableViewController: UITableViewController {
    // MARK: Properties
    @IBOutlet weak var OrientationTestPressed: UITableViewCell!
    
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
    
}
