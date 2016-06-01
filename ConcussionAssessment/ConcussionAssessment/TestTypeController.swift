//
//  TestTypeController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 5/31/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import CoreData

class TestTypeController: UITableViewController {
    
    
    var baseline: UITableViewCell = UITableViewCell()
    var newInjury: UITableViewCell = UITableViewCell()
    var postInjury: UITableViewCell = UITableViewCell()
    
    var currentPlayerID: String
    var originalView: Int
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Select Type of Test"
        
        
        self.baseline.textLabel?.text = "Baseline Test"
        self.baseline.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.baseline.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.newInjury.textLabel?.text = "New Injury"
        self.newInjury.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.newInjury.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.postInjury.textLabel?.text = "Post-Injury Test"
        self.postInjury.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.postInjury.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
    }
    
    init(playerID: String, original: Int) {
        currentPlayerID = playerID
        originalView = original
        super.init(style: UITableViewStyle.Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            case 0: return self.baseline
            case 1: return self.newInjury
            case 2: return self.postInjury
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
                /********************************************************************************************
                 * BASELINE INJURY TEST
                 ********************************************************************************************/
                database.insertNewScore(currentPlayerID, scoreID: currentScoreID!)
                database.setBaselineForScore(currentScoreID!, baseline: currentScoreID!)
                database.setScoreType(currentScoreID!, type: "Baseline")
                database.setBaselineForPlayer(currentPlayerID, baseline: currentScoreID!)
                
                let (sympEvalPageTitles, sympEvalTestName, sva, sympEvalInstr) = getSympEvalStrings()
                let(orientationTitle, orientationTestName, orientationCOA, orientationInstr) = getCogAssOrientationStrings()
                let(memPageTitle, memTestName, memCOA, memInstr) = getCogAssImmediateStrings()
                let(numPageTitle, numTestName, numCOA, numInstr) = getCogAssNumStrings()
                let(monthPageTitle, monthTestName, monthCOA, monthInstr) = getCogAssMonthStrings()
                let(sacPageTitle,sacTestName, sac, sacInstr) = getSACDelayRecallStrings(memPageTitle)
                let (balancePageTitles, balanceTestName, balanceInstructions) = getBalanceStrings()
                
                //SAC DELAYED RECALL: IMMEDIATE MEMORY
                let SacDelayedRecallView = TablePageViewController(pageTitles: sacPageTitle, labelArray: sac, testName: sacTestName, instructionPage: nil, instructions: sacInstr, next: nil, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: true) as TablePageViewController
                
                //BESS TEST
                let BalanceView = BalanceViewController(pageTitles: balancePageTitles, testName: balanceTestName, instructions: balanceInstructions, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], next: SacDelayedRecallView) as BalanceViewController
                
                //COGNATIVE ASSESSMENT: MONTH
                let CognitiveMonthsBackwardsView = TablePageViewController(pageTitles: monthPageTitle, labelArray: monthCOA, testName: monthTestName, instructionPage: nil, instructions: monthInstr, nextBalance: BalanceView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: false) as TablePageViewController
                
                //COGNATIVE ASSESSMENT: NUMBER
                let CognitiveNumBackwardsView = TablePageViewController(pageTitles: numPageTitle, labelArray: numCOA, testName: numTestName, instructionPage: nil, instructions: numInstr, next: CognitiveMonthsBackwardsView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: [0, 1], singlePage: false) as TablePageViewController
                
                //COGNATIVE ASSESSMENT: IMMEDIATE MEMORY
                let CognitiveImmediateMemView = TablePageViewController(pageTitles: memPageTitle, labelArray: memCOA, testName: memTestName, instructionPage: nil, instructions: memInstr, next: CognitiveNumBackwardsView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: [0, 3], singlePage: true) as TablePageViewController
                
                //COGNATIVE ASSESSMENT: ORIENTATION
                let CognitiveOrientationView = TablePageViewController(pageTitles: orientationTitle, labelArray: orientationCOA, testName: orientationTestName, instructionPage: nil, instructions: orientationInstr, next: CognitiveImmediateMemView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: false) as TablePageViewController
                
                //SYMPTOM EVALUATION
                let SymptomView = TablePageViewController(pageTitles: sympEvalPageTitles, labelArray: sva, testName: sympEvalTestName, instructionPage: nil, instructions: sympEvalInstr, next: CognitiveOrientationView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: false) as TablePageViewController
                
                self.navigationController?.pushViewController(SymptomView, animated: true)
                break;
            case 1:
                /********************************************************************************************
                 * INJURY TEST
                 ********************************************************************************************/
                // set new baseline, compare dates???
                // set score's baseline to new baseline.
                
                if(database.numPlayerScores(currentPlayerID) <= 0 )
                {
                    let alert = UIAlertController(title: "Alert", message: "No Baseline Score. Please take a Baseline Test", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else
                {
                    let (setOfScores, numScores) = database.scoresWithBaseline(database.getPlayerBaseline(currentPlayerID))
                    
                    var latestScore = setOfScores[0]
                    if(numScores > 1)
                    {
                        for index in 1 ... (numScores - 1)
                        {
                            if database.scoreWithID(setOfScores[index-1])[0].date > database.scoreWithID(setOfScores[index])[0].date
                            {
                                latestScore = setOfScores[index-1]
                            }
                            else
                            {
                                latestScore = setOfScores[index]
                            }
                        }
                    }
                    
                    database.insertNewScore(currentPlayerID, scoreID: currentScoreID!)
                    database.setBaselineForScore(currentScoreID!, baseline: latestScore)
                    database.setScoreType(currentScoreID!, type: "Injury")
                    database.setBaselineForPlayer(currentPlayerID, baseline: latestScore)
                    
                    let (sympEvalPageTitles, sympEvalTestName, sva, sympEvalInstr) = getSympEvalStrings()
                    let(orientationTitle, orientationTestName, orientationCOA, orientationInstr) = getCogAssOrientationStrings()
                    let(memPageTitle, memTestName, memCOA, memInstr) = getCogAssImmediateStrings()
                    let(numPageTitle, numTestName, numCOA, numInstr) = getCogAssNumStrings()
                    let(monthPageTitle, monthTestName, monthCOA, monthInstr) = getCogAssMonthStrings()
                    let(sacPageTitle,sacTestName, sac, sacInstr) = getSACDelayRecallStrings(memPageTitle)
                    let (balancePageTitles, balanceTestName, balanceInstructions) = getBalanceStrings()
                  
                    //SAC DELAYED RECALL: IMMEDIATE MEMORY
                    let SacDelayedRecallView = TablePageViewController(pageTitles: sacPageTitle, labelArray: sac, testName: sacTestName, instructionPage: nil, instructions: sacInstr, next: nil, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: true) as TablePageViewController
                  
                    //BESS TEST
                    let BalanceView = BalanceViewController(pageTitles: balancePageTitles, testName: balanceTestName, instructions: balanceInstructions, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], next: SacDelayedRecallView) as BalanceViewController
                    
                    //COGNATIVE ASSESSMENT: MONTH
                    let CognitiveMonthsBackwardsView = TablePageViewController(pageTitles: monthPageTitle, labelArray: monthCOA, testName: monthTestName, instructionPage: nil, instructions: monthInstr, nextBalance: BalanceView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: false) as TablePageViewController
                    
                    //COGNATIVE ASSESSMENT: NUMBER
                    let CognitiveNumBackwardsView = TablePageViewController(pageTitles: numPageTitle, labelArray: numCOA, testName: numTestName, instructionPage: nil, instructions: numInstr, next: CognitiveMonthsBackwardsView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: [0, 1], singlePage: false) as TablePageViewController
                    
                    //COGNATIVE ASSESSMENT: IMMEDIATE MEMORY
                    let CognitiveImmediateMemView = TablePageViewController(pageTitles: memPageTitle, labelArray: memCOA, testName: memTestName, instructionPage: nil, instructions: memInstr, next: CognitiveNumBackwardsView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: [0, 3], singlePage: true) as TablePageViewController
                    
                    //COGNATIVE ASSESSMENT: ORIENTATION
                    let CognitiveOrientationView = TablePageViewController(pageTitles: orientationTitle, labelArray: orientationCOA, testName: orientationTestName, instructionPage: nil, instructions: orientationInstr, next: CognitiveImmediateMemView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: false) as TablePageViewController
                    
                    //SYMPTOM EVALUATION
                    let SymptomView = TablePageViewController(pageTitles: sympEvalPageTitles, labelArray: sva, testName: sympEvalTestName, instructionPage: nil, instructions: sympEvalInstr, next: CognitiveOrientationView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: false) as TablePageViewController
                    
                    self.navigationController?.pushViewController(SymptomView, animated: true)
                }

                break;
            case 2:
                /********************************************************************************************
                * POST INJURY TEST
                ********************************************************************************************/
                if(database.numPlayerScores(currentPlayerID) == 1)
                {
                    let alert = UIAlertController(title: "Alert", message: "No Current Injury. Please create New Injury.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if(database.numPlayerScores(currentPlayerID) <= 0 )
                {
                    let alert = UIAlertController(title: "Alert", message: "No Baseline Score. Please take a Baseline Test", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else
                {
                    //database.scoreWithBaseLine
                    database.insertNewScore(currentPlayerID, scoreID: currentScoreID!)
                    database.setScoreType(currentScoreID!, type: "Post-Injury")
                    let baselineID = database.getPlayerBaseline(currentPlayerID)
                    database.setBaselineForScore(currentScoreID!, baseline: baselineID)
                    
                    let (sympEvalPageTitles, sympEvalTestName, sva, sympEvalInstr) = getSympEvalStrings()
                    let(orientationTitle, orientationTestName, orientationCOA, orientationInstr) = getCogAssOrientationStrings()
                    let(memPageTitle, memTestName, memCOA, memInstr) = getCogAssImmediateStrings()
                    let(numPageTitle, numTestName, numCOA, numInstr) = getCogAssNumStrings()
                    let(monthPageTitle, monthTestName, monthCOA, monthInstr) = getCogAssMonthStrings()
                    let(sacPageTitle,sacTestName, sac, sacInstr) = getSACDelayRecallStrings(memPageTitle)
                    let (balancePageTitles, balanceTestName, balanceInstructions) = getBalanceStrings()
                  
                    //SAC DELAYED RECALL: IMMEDIATE MEMORY
                    let SacDelayedRecallView = TablePageViewController(pageTitles: sacPageTitle, labelArray: sac, testName: sacTestName, instructionPage: nil, instructions: sacInstr, next: nil, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: true) as TablePageViewController
                  
                    //BESS TEST
                    let BalanceView = BalanceViewController(pageTitles: balancePageTitles, testName: balanceTestName, instructions: balanceInstructions, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], next: SacDelayedRecallView) as BalanceViewController
                  
                    //COGNATIVE ASSESSMENT: MONTH
                    let CognitiveMonthsBackwardsView = TablePageViewController(pageTitles: monthPageTitle, labelArray: monthCOA, testName: monthTestName, instructionPage: nil, instructions: monthInstr, nextBalance: BalanceView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: false) as TablePageViewController
                    
                    //COGNATIVE ASSESSMENT: NUMBER
                    let CognitiveNumBackwardsView = TablePageViewController(pageTitles: numPageTitle, labelArray: numCOA, testName: numTestName, instructionPage: nil, instructions: numInstr, next: CognitiveMonthsBackwardsView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: [0, 1], singlePage: false) as TablePageViewController
                    
                    //COGNATIVE ASSESSMENT: IMMEDIATE MEMORY
                    let CognitiveImmediateMemView = TablePageViewController(pageTitles: memPageTitle, labelArray: memCOA, testName: memTestName, instructionPage: nil, instructions: memInstr, next: CognitiveNumBackwardsView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: [0, 3], singlePage: true) as TablePageViewController
                    
                    //COGNATIVE ASSESSMENT: ORIENTATION
                    let CognitiveOrientationView = TablePageViewController(pageTitles: orientationTitle, labelArray: orientationCOA, testName: orientationTestName, instructionPage: nil, instructions: orientationInstr, next: CognitiveImmediateMemView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: false) as TablePageViewController
                    
                    //SYMPTOM EVALUATION
                    let SymptomView = TablePageViewController(pageTitles: sympEvalPageTitles, labelArray: sva, testName: sympEvalTestName, instructionPage: nil, instructions: sympEvalInstr, next: CognitiveOrientationView, original: self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - originalView], numTrials: nil, singlePage: false) as TablePageViewController
                    
                    self.navigationController?.pushViewController(SymptomView, animated: true)
                }
                
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

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate: Comparable { }