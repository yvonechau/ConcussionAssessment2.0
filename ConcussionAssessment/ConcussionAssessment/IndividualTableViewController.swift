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
      
      let pageControl = UIPageControl.appearance()
      pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
      pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
      pageControl.backgroundColor = UIColor.darkGrayColor()
      
      
      switch(indexPath.item) {
        case 0:
//            let GlasgowView = GlasgowTestViewController() as GlasgowTestViewController
            let pageTitles : Array<String> = ["Best Eye Response", "No Verbal Response", "Best Motor Response"]
            let testName : String = "Glasgow Coma Scale"
            
            let gla : Array<Array<String>> = [["No eye opening", "Eye Opening in Response To Pain", "Eye opening in Speech", "Eyes Opening Spontaneously"], ["No Verbal Response", "Incomprehensible Sounds", "Incomprehensible Words", "Confused", "Oriented"],["No Motor Response", "Extension to Pain", "Abnormal flexion to pain", "Flexion/Withdrawal to Pain", "Localizes to Pain", "Obeys Command"]]
            
            let GlasgowView = TablePageViewController(pageTitles: pageTitles, labelArray: gla, testName: testName, instructionPage: nil) as TablePageViewController
            self.navigationController?.pushViewController(GlasgowView, animated: true)
        case 1:
//            let MaddocksView = MaddocksViewController() as MaddocksViewController
//            self.navigationController?.pushViewController(MaddocksView, animated: true)
      
        
            let pageTitles : Array<String> = ["At what venue are we today?", "Which half is it now?", "Who scored last in this match", "What did you play last week?", "Did your team win the last game?"]
            let testName : String = "Maddocks Test"
            
            let ma : [[String]] = [[String]](count: pageTitles.count, repeatedValue: ["Correct", "Incorrect"])
            
            let MaddocksView = TablePageViewController(pageTitles: pageTitles, labelArray: ma, testName: testName, instructionPage: nil) as TablePageViewController
            self.navigationController?.pushViewController(MaddocksView, animated: true)

        
        case 2:
          
            let pageTitles : Array<String> = ["Headache", "Pressure in Head", "Neck Pain", "Nausea or Vomiting", "Dizziness", "Blurred Vision", "Balance Problems", "Sensitivity to Light", "Sensitivity to Noise", "Feeling Slowed Down", "Feeling like 'in a fog'", "Don't Feel Right", "Difficulty Concentrating", "Difficulty Remembering", "Fatigue or Low Energy", "Confusion", "Drowsiness", "Trouble Falling Asleep", "More Emotional", "Irrability", "Sadness", "Nervous or Anxious"]
            let testName : String = "Symptom Evaluation"
            
            let sva : [[String]] = [[String]](count: pageTitles.count, repeatedValue: ["None", "Less Mild", "Mild", "Less Moderate", "Moderate", "Less Severe", "Severe"])
            
            let SymptomView = TablePageViewController(pageTitles: pageTitles, labelArray: sva, testName: testName, instructionPage: nil) as TablePageViewController
            self.navigationController?.pushViewController(SymptomView, animated: true)
        case 3:
//            let CognitiveView = CognitiveTableViewController(style: UITableViewStyle.Grouped) as CognitiveTableViewController
//            self.navigationController?.pushViewController(CognitiveView, animated: true)
        
            let pageTitles : Array<String> = ["What month is it?", "What is the date?", "What is the day of the week?", "What year is it?", "What time is it right now? (Within 1 hour)"]
            let testName : String = "Cognitive Assessment: Orientation"
            
            let coa : [[String]] = [[String]](count: pageTitles.count, repeatedValue: ["Correct", "Incorrect"])
          
            let CognitiveOrientationView = TablePageViewController(pageTitles: pageTitles, labelArray: coa, testName: testName, instructionPage: nil) as TablePageViewController
            self.navigationController?.pushViewController(CognitiveOrientationView, animated: true)

//        case 4:
//      
//            let pageTitles : Array<String> = ["What month is it?", "What is the date?", "What is the day of the week?", "What year is it?", "What time is it right now? (Within 1 hour)"]
//            let testName : String = "Cognitive Assessment: Orientation"
//            
//            let sva : [[String]] = [[String]](count: pageTitles.count, repeatedValue: ["Correct", "Incorrect"]])
//            
//            let CognitiveOrientationView = TablePageViewController(pageTitles: pageTitles, labelArray: sva, testName: testName) as TablePageViewController
//            self.navigationController?.pushViewController(CognitiveOrientationView, animated: true)

        
        case 4:
            let BalanceView = BalanceViewController() as BalanceViewController
            self.navigationController?.pushViewController(BalanceView, animated: true)
        default:
            fatalError("Unknown test choice.")
            
        }
    }
  
}
