//
//  CognitiveTableViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class CognitiveTableViewController: UITableViewController {
    
    let LabelArray = ["Orientation", "Immediate Memory", "Concentration"]
    let DetailLabelArray: [String] = ["Whether the patient is aware of what time it is.", "Memory/recollection test.", "Remembering information backwards."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cognitive Assessment"
        self.navigationItem.prompt = "Assessment for <Player.name>"
        
        // let TestMenuTableView = UITableView()
        // TestMenuTableView.dataSource = self
        // TestMenuTableView.delegate = self
        // TestMenuTableView.backgroundColor = UIColor.whiteColor()
        // Above same as UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return LabelArray.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            return "Evaluations"
        default:
            return ""
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MenuCell")
        switch(indexPath.section) {
        case 0:
            switch(indexPath.section) {
            case 0:
                Cell.textLabel?.text = LabelArray[indexPath.section]
                Cell.detailTextLabel?.text = DetailLabelArray[indexPath.section]
                Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            default:
                fatalError("Bad choice")
            }
        case 1:
            switch(indexPath.section) {
            case 1:
                Cell.textLabel?.text = LabelArray[indexPath.section]
                Cell.detailTextLabel?.text = DetailLabelArray[indexPath.section]
                Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            default:
                fatalError("Bad choice")
            }
        case 2:
            switch(indexPath.section) {
            case 2:
                Cell.textLabel?.text = LabelArray[indexPath.section]
                Cell.detailTextLabel?.text = DetailLabelArray[indexPath.section]
                Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            default:
                fatalError("Bad choice")
            }
        default:
            fatalError("Bad choice")
        }

        return Cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.item) {
            case 0:
                let CognitiveOrientation = CognitiveOrientationViewController() as CognitiveOrientationViewController
                self.navigationController?.pushViewController(CognitiveOrientation, animated: true)
            default:
                fatalError("Unknown test choice.")
            }
        case 1:
            switch(indexPath.item) {
            case 0:
                let CognitiveImmediate = CognitiveImmediateViewController() as CognitiveImmediateViewController
                self.navigationController?.pushViewController(CognitiveImmediate, animated: true)
            default:
                fatalError("Unknown test choice.")
            }
        case 2:
            switch(indexPath.item) {
            case 0:
                let CognitiveConcentration = CognitiveConcentrationViewController() as CognitiveConcentrationViewController
                self.navigationController?.pushViewController(CognitiveConcentration, animated: true)
            default:
                fatalError("Unknown test choice.")
            }
        default:
            fatalError("Unknown section.")
        }
    }

}
