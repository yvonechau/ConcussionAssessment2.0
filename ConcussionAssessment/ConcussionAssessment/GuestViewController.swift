//
//  GuestViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 4/5/2016
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit
import CoreData

class GuestViewController: UITableViewController {
    
    let LabelArray = ["Take Full Diagnostic", "Take Individual Tests"]
    
    override func loadView() {
        super.loadView()
        
        self.title = "Guest"
    }
    
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Returns the number of elements to be made into cells in table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LabelArray.count
    }
    
    // Creates cells in table based on the number of items in LabelArray
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "GuestCell")
        
        Cell.textLabel?.text = LabelArray[indexPath.item]
        Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return Cell
    }
    
    
    // Configure the row selection code for any cells that you want to customize the row selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
              
                let pageControl = UIPageControl.appearance()
                pageControl.pageIndicatorTintColor = UIColor.whiteColor()
                pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
                pageControl.backgroundColor = UIColor(rgb: 0x002855)
                currentScoreID = NSUUID().UUIDString
                database.insertNewScore("no player", scoreID: currentScoreID!)
                
                let (sympEvalPageTitles, sympEvalTestName, sva, sympEvalInstr) = getSympEvalStrings()
                let(orientationTitle, orientationTestName, orientationCOA, orientationInstr) = getCogAssOrientationStrings()
                let(memPageTitle, memTestName, memCOA, memInstr) = getCogAssImmediateStrings()
                let(numPageTitle, numTestName, numCOA, numInstr) = getCogAssNumStrings()
                let(monthPageTitle, monthTestName, monthCOA, monthInstr) = getCogAssMonthStrings()
                let(sacPageTitle,sacTestName, sac, sacInstr) = getSACDelayRecallStrings(memPageTitle)
                
                //SAC DELAYED RECALL: IMMEDIATE MEMORY
                let SacDelayedRecallView = TablePageViewController(pageTitles: sacPageTitle, labelArray: sac, testName: sacTestName, instructionPage: nil, instructions: sacInstr, next: nil, original: self, numTrials: nil, singlePage: true) as TablePageViewController
                
                
                //COGNATIVE ASSESSMENT: MONTH
                let CognitiveMonthsBackwardsView = TablePageViewController(pageTitles: monthPageTitle, labelArray: monthCOA, testName: monthTestName, instructionPage: nil, instructions: monthInstr, next: SacDelayedRecallView, original: self, numTrials: nil, singlePage: false) as TablePageViewController
                
                //COGNATIVE ASSESSMENT: NUMBER
                let CognitiveNumBackwardsView = TablePageViewController(pageTitles: numPageTitle, labelArray: numCOA, testName: numTestName, instructionPage: nil, instructions: numInstr, next: CognitiveMonthsBackwardsView, original: self, numTrials: [0, 1], singlePage: false) as TablePageViewController
                
                //COGNATIVE ASSESSMENT: IMMEDIATE MEMORY
                let CognitiveImmediateMemView = TablePageViewController(pageTitles: memPageTitle, labelArray: memCOA, testName: memTestName, instructionPage: nil, instructions: memInstr, next: CognitiveNumBackwardsView, original: self, numTrials: [0, 3], singlePage: true) as TablePageViewController
                
                //COGNATIVE ASSESSMENT: ORIENTATION
                let CognitiveOrientationView = TablePageViewController(pageTitles: orientationTitle, labelArray: orientationCOA, testName: orientationTestName, instructionPage: nil, instructions: orientationInstr, next: CognitiveImmediateMemView, original: self, numTrials: nil, singlePage: false) as TablePageViewController
                
                //SYMPTOM EVALUATION
                let SymptomView = TablePageViewController(pageTitles: sympEvalPageTitles, labelArray: sva, testName: sympEvalTestName, instructionPage: nil, instructions: sympEvalInstr, next: CognitiveOrientationView, original: self, numTrials: nil, singlePage: false) as TablePageViewController
                
                self.navigationController?.pushViewController(SymptomView, animated: true)
                
                break;
            case 1:
                let IndividualController = IndividualTableViewController(style: UITableViewStyle.Grouped)
                //commented out because i commented out this function
                //database.insertNewScoreWithoutPlayer(currentScoreID!)
                self.navigationController?.pushViewController(IndividualController, animated: true)
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
    
}