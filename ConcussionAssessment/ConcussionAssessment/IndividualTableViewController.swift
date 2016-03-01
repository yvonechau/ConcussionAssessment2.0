//
//  TestMenuTableViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class IndividualTableViewController: UITableViewController {
    
    let LabelArray = ["Maddocks Score", "Symptom Evaluation", "Cognitive Assessment", "Balance Examination"]
    let DetailLabelArray: [String] = ["Questionnaire for patient.", "Checking to see how the patient is feeling.", "Checking details.", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tests"
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
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
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch(section) {
        case 0:
            return "Individual Tests"
        default:
            return "Nil"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MenuCell")
        
        Cell.textLabel?.text = LabelArray[indexPath.item]
        Cell.detailTextLabel?.text = DetailLabelArray[indexPath.item]
        Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return Cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.item) {
        case 0:
            let MaddocksView = MaddocksViewController() as MaddocksViewController
            self.navigationController?.pushViewController(MaddocksView, animated: true)
        case 1:
            let pageControl = UIPageControl.appearance()
            pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
            pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
            pageControl.backgroundColor = UIColor.whiteColor()
            let SymptomView = SymptomViewController() as SymptomViewController
            self.navigationController?.pushViewController(SymptomView, animated: true)
        case 2:
            let CognitiveView = CognitiveTableViewController(style: UITableViewStyle.Grouped) as CognitiveTableViewController
            self.navigationController?.pushViewController(CognitiveView, animated: true)
        case 3:
            let BalanceView = BalanceViewController() as BalanceViewController
            self.navigationController?.pushViewController(BalanceView, animated: true)
        default:
            fatalError("Unknown test choice.")
            
        }
    }
  
}
