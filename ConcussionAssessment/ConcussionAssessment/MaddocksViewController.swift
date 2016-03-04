//
//  MaddocksViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

//Things to fix:
//- Way to go to next test
//- Tally Scores out of 5 after going to next test
//- A checker to see if all answers have been filled out if proceeding to next test
//- Fix Dimmensions to fit all ios devices
//- UI Design


import UIKit

class MaddocksViewController: UITableViewController
{
  var maddocks: [Maddocks] = []
  let questionArray = ["At what venue are we today?", "Which half is it now?", "Who scored last in this match?", "What did you play last week?", "Did your team win the last game?"]
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.title = "Maddocks Test"
    
    for question in questionArray{
      let maddock = Maddocks(q: question)
      maddocks.append(maddock)
    }
    
    tableView = UITableView(frame: view.bounds, style: .Grouped)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .None
    tableView.registerClass(MaddocksCell.self, forCellReuseIdentifier: NSStringFromClass(MaddocksCell))
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questionArray.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier( NSStringFromClass(MaddocksCell), forIndexPath: indexPath) as! MaddocksCell
    cell.maddocks = maddocks[indexPath.row]
    self.tableView.rowHeight = 120.0
    return cell
  }
  
  //  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
  //    return 70
  //  }
  
  
}

class Maddocks
{
  var question: String?
  var answer: String?
  init(q: String)
  {
    self.question = q
    self.answer = " "
  }
}

class MaddocksCell: UITableViewCell
{
  //let padding: CGFloat = 5
  var questionLabel: UILabel!
  var correctButton: UIButton!
  var incorrectButton: UIButton!
  var answerLabel: UILabel!
  
  var maddocks: Maddocks?
    {
    didSet
    {
      questionLabel.backgroundColor = UIColor.orangeColor()
      questionLabel.text = maddocks!.question
      
      correctButton.backgroundColor = UIColor.cyanColor()
      correctButton.setTitle("Correct", forState: UIControlState.Normal)
      
      incorrectButton.backgroundColor = UIColor.cyanColor()
      incorrectButton.setTitle("Incorrect", forState: UIControlState.Normal)
      
      answerLabel.backgroundColor = UIColor.redColor()
      setNeedsLayout()
      
    }
  }
  
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?)
  {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = UIColor.whiteColor()
    selectionStyle = .None
    
    questionLabel = UILabel(frame: CGRectZero)
    questionLabel.textAlignment = .Left
    questionLabel.textColor = UIColor.blackColor()
    contentView.addSubview(questionLabel)
    
    
    correctButton = UIButton(frame: CGRectZero)
    correctButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    contentView.addSubview(correctButton)
    
    incorrectButton = UIButton(frame:CGRectZero)
    incorrectButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    contentView.addSubview(incorrectButton)
    
    answerLabel = UILabel(frame: CGRectZero)
    answerLabel.textAlignment = .Center
    answerLabel.textColor = UIColor.whiteColor()
    contentView.addSubview(answerLabel)
    
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
  }
  
  func buttonAction(sender:UIButton!)
  {
    print("\(sender.currentTitle!) tapped")
    answerLabel.text = "\(sender.currentTitle!)"

  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    questionLabel.frame = CGRectMake(0, 0, frame.width, 40)
    correctButton.frame = CGRectMake(10, 80, 100, 40)
    incorrectButton.frame = CGRectMake(150, 80, 100, 40)
    answerLabel.frame = CGRectMake(290, 80, 100, 40)
  }
}
