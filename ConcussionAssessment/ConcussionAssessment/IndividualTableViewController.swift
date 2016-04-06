//
//  TestMenuTableViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class IndividualTableViewController: UITableViewController {
    
    let LabelArray = ["Glasgow Coma Scale", "Maddocks Score", "Symptom Evaluation", "Cognitive Assessment", "Balance Examination"]
    let DetailLabelArray: [String] = ["", "Questionnaire for patient.", "Checking to see how the patient is feeling.", "Checking details.", ""]
    
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
            let GlasgowView = GlasgowTestViewController() as GlasgowTestViewController
            self.navigationController?.pushViewController(GlasgowView, animated: true)
        case 1:
            let MaddocksView = MaddocksViewController() as MaddocksViewController
            self.navigationController?.pushViewController(MaddocksView, animated: true)
        case 2:
            let pageControl = UIPageControl.appearance()
            pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
            pageControl.currentPageIndicatorTintColor = UIColor.darkGrayColor()
            pageControl.backgroundColor = UIColor.whiteColor()
            
            var pageTitles : Array<String> = ["Headache", "Pressure in Head", "Neck Pain", "Nausea or Vomiting", "Dizziness", "Blurred Vision", "Balance Problems", "Sensitivity to Light", "Sensitivity to Noise", "Feeling Slowed Down", "Feeling like 'in a fog'", "Don't Feel Right", "Difficulty Concentrating", "Difficulty Remembering", "Fatigue or Low Energy", "Confusion", "Drowsiness", "Trouble Falling Asleep", "More Emotional", "Irrability", "Sadness", "Nervous or Anxious"]

            
            let SymptomView = TablePageViewController(pageTitles: pageTitles) as TablePageViewController
            self.navigationController?.pushViewController(SymptomView, animated: true)
        case 3:
            let CognitiveView = CognitiveTableViewController(style: UITableViewStyle.Grouped) as CognitiveTableViewController
            self.navigationController?.pushViewController(CognitiveView, animated: true)
        case 4:
            let BalanceView = BalanceViewController() as BalanceViewController
            self.navigationController?.pushViewController(BalanceView, animated: true)
        default:
            fatalError("Unknown test choice.")
            
        }
    }
  
}
