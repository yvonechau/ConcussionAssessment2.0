//
//  CognitiveTableViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class CognitiveTableViewController: UITableViewController {
    
    let NumberOfSections = 1
    
    let LabelArray = ["Orientation", "Immediate Memory", "Concentration"]
    let DetailLabelArray: [String] = ["Whether the patient is aware of what time it is.", "Memory/recollection test.", "Remembering numbers backwards."]
    
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
        return LabelArray.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return NumberOfSections
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            return "Individual tests"
        default:
            return "Nil"
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MenuCell")
        
        Cell.textLabel?.text = LabelArray[indexPath.row]
        Cell.detailTextLabel?.text = DetailLabelArray[indexPath.item]
        Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return Cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.item) {
            case 0:
                let CognitiveOrientation = CognitiveOrientationViewController() as CognitiveOrientationViewController
                self.navigationController?.pushViewController(CognitiveOrientation, animated: true)
            case 1:
                let CognitiveImmediate = CognitiveImmediateViewController() as CognitiveImmediateViewController
                self.navigationController?.pushViewController(CognitiveImmediate, animated: true)
            case 2:
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
