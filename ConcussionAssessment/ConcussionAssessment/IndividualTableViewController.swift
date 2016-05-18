//
//  TestMenuTableViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class IndividualTableViewController: UITableViewController {
    
    let LabelArray = ["Glasgow Coma Scale", "Maddocks Score", "Symptom Evaluation", "Cognitive Assessment", "Balance Examination", "Neck Examination"]
    let DetailLabelArray: [String] = ["", "Questionnaire for patient.", "Checking to see how the patient is feeling.", "Checking details.", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tests"
        currentScoreID = NSUUID().UUIDString
        database.insertNewScore("no player", scoreID: currentScoreID!)
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
      pageControl.pageIndicatorTintColor = UIColor.whiteColor()
      pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
      pageControl.backgroundColor = UIColor(rgb: 0x002855)
      
      switch(indexPath.item) {
        /******************************************************************************************
         * GLASGOW TEST
         *******************************************************************************************/
        case 0:
            let takeGlasgowTest = ListPlayerProfileController(style: UITableViewStyle.Grouped, type: "Glasgow", original: 2)
            self.navigationController?.pushViewController(takeGlasgowTest, animated: true)
        
        /******************************************************************************************
         * MADDOCKS TEST
         *******************************************************************************************/
        case 1:
            let takeMaddocksTest = ListPlayerProfileController(style: UITableViewStyle.Grouped, type: "Maddocks", original: 2)
            self.navigationController?.pushViewController(takeMaddocksTest, animated: true)
        
        /******************************************************************************************
         * SYMPTOM EVALUATION
         *******************************************************************************************/
        case 2:
            let takeSymptomEvaluation = ListPlayerProfileController(style: UITableViewStyle.Grouped, type: "Symptom Evaluation", original: 2)
            self.navigationController?.pushViewController(takeSymptomEvaluation, animated: true)
        
        /******************************************************************************************
         * COGNITIVE ASSESSMENT
         *******************************************************************************************/
        case 3:
            let takeCognitiveAssessment = ListPlayerProfileController(style: UITableViewStyle.Grouped, type: "Cognative Assessment", original: 2)
            self.navigationController?.pushViewController(takeCognitiveAssessment, animated: true)
        /******************************************************************************************
         * BESS
         *******************************************************************************************/
        case 4:
            let takeBessTest = ListPlayerProfileController(style: UITableViewStyle.Grouped, type: "BESS", original: 2)
            self.navigationController?.pushViewController(takeBessTest, animated: true)
            
        /******************************************************************************************
         * NECK EXAMINATION
         *******************************************************************************************/
        case 5:
            let takeNeckExamination = ListPlayerProfileController(style: UITableViewStyle.Grouped, type: "Neck Examination", original: 2)
            self.navigationController?.pushViewController(takeNeckExamination, animated:true)

        default:
            fatalError("Unknown test choice.")
            
        }
    }
  
}

func getGlasgowStrings() -> (Array<String>, String, Array<Array<String>>, String)
{
    let pageTitles : Array<String> = ["Best Eye Response", "No Verbal Response", "Best Motor Response"]
    let testName = "Glasgow Coma Scale"
    
    let gla = [["No eye opening", "Eye Opening in Response To Pain", "Eye opening in Speech", "Eyes Opening Spontaneously"], ["No Verbal Response", "Incomprehensible Sounds", "Incomprehensible Words", "Confused", "Oriented"],["No Motor Response", "Extension to Pain", "Abnormal flexion to pain", "Flexion/Withdrawal to Pain", "Localizes to Pain", "Obeys Command"]]
    let instr  = "Rate the individual's responses for each page."
    
    return(pageTitles, testName, gla, instr)
}

func getMaddocksStrings() -> (Array<String>, String, Array<Array<String>>, String)
{
    let pageTitles : Array<String> = ["At what venue are we today?", "Which half is it now?", "Who scored last in this match", "What did you play last week?", "Did your team win the last game?"]
    let testName : String = "Maddocks Test"
    
    let ma : [[String]] = [[String]](count: pageTitles.count, repeatedValue: ["Incorrect", "Correct"])
    let instr : String = "Repeat the following: \n\n\"I am going to ask you a few questions, please listen carefully and give your best efforts.\"\n Record whether responses are correct or incorrect."
    
    return(pageTitles, testName, ma, instr)
}

func getSympEvalStrings() -> (Array<String>, String, Array<Array<String>>, String)
{
    let pageTitles : Array<String> = ["Headache", "Pressure in Head", "Neck Pain", "Nausea or Vomiting", "Dizziness", "Blurred Vision", "Balance Problems", "Sensitivity to Light", "Sensitivity to Noise", "Feeling Slowed Down", "Feeling like 'in a fog'", "Don't Feel Right", "Difficulty Concentrating", "Difficulty Remembering", "Fatigue or Low Energy", "Confusion", "Drowsiness", "Trouble Falling Asleep", "More Emotional", "Irrability", "Sadness", "Nervous or Anxious"]
    let testName : String = "Symptom Evaluation"
    
    let sva : [[String]] = [[String]](count: pageTitles.count, repeatedValue: ["None", "Less Mild", "Mild", "Less Moderate", "Moderate", "Less Severe", "Severe"])
    let instr : String = "Rate each of the following symptoms by the amount of severity."
    
    return(pageTitles, testName, sva, instr)
}

func getCogAssMonthStrings() -> (Array<String>, String, Array<Array<String>>, String)
{
    let pageTitle: [String] = ["Dec-Nov-Oct-Sept-Aug-Jul-Jun-May-Apr-Mar-Feb-Jan"]
    let coa = [[String]](count: pageTitle.count, repeatedValue: ["Incorrect", "Correct"])
    let testName : String = "Cognitive Assessment: Months in Reverse Order"
    let instr : String = "Repeat the following: \n\n\"Now tell me the months of the year in reverse order. Start with the last month and go backwards. So you'll say December, November... Go ahead.\""
    
    return(pageTitle, testName, coa, instr)
}


func getCogAssNumStrings() -> (Array<String>, String, Array<Array<String>>, String)
{
    let numMemSetList: [[String]] = [["4-9-3", "3-8-1-4", "6-2-9-7-1", "7-1-8-4-6-2"], ["6-2-9", "3-2-7-9", "1-5-2-8-6", "5-3-9-1-4-8"], ["5-2-6", "1-7-9-5", "3-8-5-2-7", "8-3-1-8-6-4"], ["4-1-5", "4-9-6-8", "6-1-8-4-3", "7-2-4-8-5-7"]]
    
    let pageTitle: [String] = numMemSetList[Int(arc4random() % UInt32(numMemSetList.count))]
    let coa = [[String]](count: numMemSetList.count, repeatedValue: ["Incorrect", "Correct"])
    let testName = "Cognitive Assessment: Digits Backwards"
    let instr : String = "Repeat the following: \n\n\"I am going to read you a string of numbers and when I am done, you repeat them back to me backwards, in reverse order of how I read them to you. For example, if I say 7-1-9, you would say 9-1-7.\"\n\n If correct, go to next string length, if incorrect, read trial 2. Stop after incorrect on both trials. The digits should be read at rate of one per second."
    
    return (pageTitle, testName, coa, instr)
}

func getCogAssImmediateStrings() -> (Array<String>, String, Array<Array<String>>, String)
{
    let memSetList : [[String]] = [["elbow", "apple", "carpet", "saddle", "bubble"], ["candle", "paper", "sugar", "sandwich", "wagon"], ["baby", "monkey", "perfume", "sunset", "iron"], ["finger", "penny", "blanket", "lemon", "insect"]]
    
    let pageTitle: [String] = memSetList[Int(arc4random() % UInt32(memSetList.count))]
    let coa = [[String]](count: pageTitle.count, repeatedValue: ["Incorrect", "Correct"])
    let testName = "Cognitive Assessment: Immediate Memory"
    let instr = "Repeat the following: \n\n\"I am going to test your memory. I will read  you a list of words and when I am done, repeat back as many words as you can remember in any order.\"\n\n Complete all 3 trials regardless of score on trial 1 & 2. Read the words at a rate of one per second. Do not inform the individual that delayed recall will be tested.\n\n Press done when they can no longer remember the rest of the words for each trial."
    
    return (pageTitle, testName, coa, instr)
}

func getCogAssOrientationStrings() -> (Array<String>, String, Array<Array<String>>, String)
{
    let pageTitle : [String] = ["What month is it?", "What is the date?", "What is the day of the week?", "What year is it?", "What time is it right now? (Within 1 hour)"]
    let coa = [[String]](count: pageTitle.count, repeatedValue: ["Incorrect", "Correct"])
    let testName = "Cognitive Assessment: Orientation"
    let instr  = "Record whether responses are correct or incorrect."
    
    return (pageTitle, testName, coa, instr)
}

func getSACDelayRecallStrings(pageTitle: [String]) -> (Array<String>, String, Array<Array<String>>, String)
{
    let testName = "SAC Delayed Recall"
    let sac = [[String]](count: pageTitle.count, repeatedValue: ["Incorrect", "Correct"])
    let instr = "Repeat the following: \n\n\"Do you remember that list of words I read a few times earlier? Tell me as many words from the list as you can remember in any order.\"\n\n Press done when they can no longer remember the rest of the words for the trial"
    
    return(pageTitle, testName, sac, instr)
}




func getNeckStrings() -> (Array<String>, String, [[[String]]], String)
{
  
  
  let rangeOfMotion : [[String]] = [createRange(45, name: "Flexion"), createRange(45, name: "Extension"), createRange(80, name: "Right Rotation"), createRange(80, name: "Left Rotation"), createRange(45, name: "Right Lateral Flexion"), createRange(45, name: "Left Lateral Flexion")]

  let tenderness : [[String]] = [["Yes", "No", "Right Paraspinal"], ["Yes", "No", "Left Paraspinal"], ["Yes", "No", "Bony"]]
  let upperLimbSensation: [[String]] = [["Normal", "Abnormal", "Right Upper Limb"], ["Normal", "Abnormal", "Left Upper Limit"]]
  let lowerLimbSensation: [[String]] = [["Normal", "Abnormal", "Right Lower Limb"], ["Normal", "Abnormal", "Left Lower Limit"]]
  let lowerLimbStrength: [[String]] = [["Normal", "Abnormal", "Right Lower Limb"], ["Normal", "Abnormal", "Left Lower Limit"]]
  
  let pageTitle: [String] = ["Range of Motion", "Tenderness", "Upper Limb Sensation", "Upper Limb Strength", "Lower Limb Sensation", "Lower Limb Strength"]
  let pageContent: [[[String]]] = [rangeOfMotion, tenderness, upperLimbSensation, lowerLimbSensation, lowerLimbStrength]
  let testName = "Neck Examination"
  let instr = "TBA"
  
  return (pageTitle, testName, pageContent, instr)
}

func createRange(upperLimit: Int, name: String)->[String]
{
  var range = (0..<upperLimit + 5).filter{$0 % 5 == 0}.map({String($0)})
  
  range.append(name)
  return range
}
