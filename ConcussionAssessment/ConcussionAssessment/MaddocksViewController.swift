//
//  MaddocksViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class MaddocksViewController: UITableViewController
{
  let QuestionArray = ["At what venue are we today?", "Which half is it now?", "Who scored last in this match?", "What did you play last week?", "Did your team win the last game?"]
  var answer: UILabel!
  var cell: UITableViewCell!
  
  var num = 1
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.title = "Maddocks Test"
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return QuestionArray.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    //Table
    cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MenuCell")
    cell.textLabel?.text = QuestionArray[indexPath.row]
    self.tableView.rowHeight = 120.0

    //Correct Button
    let correct = UIButton(type: UIButtonType.System) as UIButton
    correct.frame = CGRectMake(10, 80, 100, 40)
    correct.setTitle("Correct", forState: UIControlState.Normal)
    correct.backgroundColor = UIColor.cyanColor()
    correct.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    correct.tag = indexPath.row
    cell.addSubview(correct)

    
    //Incorrect Button
    let incorrect = UIButton(type: UIButtonType.System) as UIButton
    incorrect.frame = CGRectMake(150, 80, 100, 40)
    incorrect.setTitle("Incorrect", forState: UIControlState.Normal)
    incorrect.backgroundColor = UIColor.cyanColor()
    incorrect.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    incorrect.tag = indexPath.row
    cell.addSubview(incorrect)

    
    //Answer Text Label
    answer = UILabel(frame: CGRectMake(290, 80, 100, 40))
    answer.textAlignment = NSTextAlignment.Center
    answer.text = "Test"
    answer.backgroundColor = UIColor.redColor()
    answer.textColor = UIColor.whiteColor()
    cell.addSubview(answer)

    
    
//    let answer = UIButton(frame: CGRectMake(10, 80, 300, 10))
//    answer.addTarget(self, action: "sliderValueChanged:", forControlEvents: UIControlEvents.ValueChanged)// set the target to respond to changes.
//    answer.userInteractionEnabled = true
//    answer.tag = indexPath.row// save the indexPath.row
//    cell.addSubview(answer)
    
//    var value = slider.value
//    let label = UILabel(frame: CGRectMake(320, 80, 100, 20))
//    if round(answer.value) == 1
//    {
//      value = true
//    }
//    else
//    {
//      value = false
//    }
//    label.text = "\(value)"
//    cell.addSubview(label)
    
    return cell
  }
  
  func buttonAction(sender:UIButton!)
  {
    print("\(sender.currentTitle!) tapped in row \(sender.tag)")
    var indexPath: NSIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
    var cell = self.tableView(tableView, cellForRowAtIndexPath:indexPath)
    //cell.answer.text = ""
    self.answer.text = "\((num++))"
  }
  //table iew global
  // make custom table view cell

  
}
