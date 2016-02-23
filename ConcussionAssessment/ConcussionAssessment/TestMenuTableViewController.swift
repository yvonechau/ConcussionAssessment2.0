//
//  TestMenuTableViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class TestMenuTableViewController: UITableViewController {
    
    let LabelArray = ["Glasgow Coma Scale", "Maddocks Test", "Symptom Evaluation", "Cognitive Assessment"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let TestMenuTableView = UITableView()
        TestMenuTableView.dataSource = self
        TestMenuTableView.delegate = self
        TestMenuTableView.backgroundColor = UIColor.whiteColor()
        // Above same as UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        TestMenuTableView.frame = CGRectMake(20, 50, 200, 400)
        
        self.view.addSubview(TestMenuTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInsection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = UITableViewCell()
        
        Cell.textLabel?.text = LabelArray[indexPath.row]
        Cell.detailTextLabel?.text = "This goes to the Glasgow Coma Scale test."
        Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return Cell
    }
}
