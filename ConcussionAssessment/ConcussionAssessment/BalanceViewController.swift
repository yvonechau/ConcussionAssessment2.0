//
//  BalanceViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController, UIPageViewControllerDataSource {
  var pageViewController: UIPageViewController?
  var testName: String
  var pageTitles : Array<String>
  var currentIndex : Int = 0
  var limitIndex: Int = 0
  var donePressed: Bool = false
  var instructions: Array<String>
  var original: UIViewController?
  var numPages: Int
  var currScore: NSNumber
  var startingViewController: BalanceView? = nil
  var cellTimerLabel: UILabel!
  var cellTimerButton: UIButton!
  var cellCounterLabel: UILabel!
  var cellIncrementButton: UIStepper!
  var timer = NSTimer()
  var timerCount = 20.00 as Float
  var count = 0 as Int
  var doneButton: UIBarButtonItem!
  var domFoot: String?
  var domFootDefault: Int
  var domFootSwitch: UISegmentedControl!

  
  init(pageTitles : Array<String>, testName : String, instructions: Array<String>, original: UIViewController?)
  {
    self.pageTitles = pageTitles
    self.testName = testName
    self.instructions = instructions
    self.original = original!
    self.numPages = 0
    self.currScore = 0
    self.domFootDefault = 1
    self.domFoot = "Right"
    super.init(nibName:nil, bundle:nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func instructionButtonPressed(sender: UIButton)
  {
    let alertView = UIAlertController(title: "Instructions", message: self.instructions[currentIndex], preferredStyle: UIAlertControllerStyle.Alert)
    alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {
      action in
      switch action.style
      {
      case .Default:
        print("default")
      case .Cancel:
        print("cancel")
      case .Destructive:
        print("destructive")
      }
      
    }))
    presentViewController(alertView, animated: true, completion: nil)
  }
  
  func doneButtonPressed(sender: UIButton)
  {
    self.donePressed = true
    self.currentIndex += 1
    self.setScore()
    self.count = 0
    self.timerCount = 20
    self.timer.invalidate()
    self.doneButton.enabled = false
    if(currentIndex == numPages)
    {
    //self.navigationController?.popToViewController(self.original!, animated: true)
      let scoreboard = ScoreBoardController(originalPage: self.original!)
      self.navigationController?.pushViewController(scoreboard, animated: true)
    }
    else
    {
      let startingViewController: BalanceView = self.viewControllerAtIndex(self.currentIndex)!
      let viewControllers = [startingViewController]
      self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
    }
    
  }
  
  func setScore()
  {
    self.currScore = Int(self.currScore) + Int(self.count)
    print("set balance score \(self.currScore)")
    
    if self.currentIndex == self.numPages
    {
      database.setBalance(currentScoreID!, score: self.currScore)
      database.setDomFoot(currentScoreID!, score: self.domFoot!)
    }

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    pageViewController!.dataSource = self
    
    if(self.startingViewController == nil) // not instantiated so it has no instruction page
    {
      self.startingViewController = viewControllerAtIndex(0)!
    }
    
    let viewControllers = [self.startingViewController!]
    pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
    pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    
    
    addChildViewController(pageViewController!)
    view.addSubview(pageViewController!.view)
    pageViewController!.didMoveToParentViewController(self)

    /***** TITLE SETTINGS ****
     *********************************/
    
    let title : [String] = self.testName.characters.split(":").map(String.init)
    
    
    if title.count > 1
    {
      self.navigationItem.prompt  = title[0]
      var subtitle : String = ""
      var index = 1
      for t in title[1..<title.count]
      {
        if index < title.count - 1
        {
          subtitle += t + ": "
        }
        else
        {
          subtitle += t
        }
        
        index += 1
      }
      self.navigationItem.title = subtitle
    }
    else
    {
      self.title = title[0]
    }
    
    /***** RIGHT NAV BAR BUTTONS ****
     *********************************/
    let infobutton = UIButton(type: UIButtonType.InfoDark)
    infobutton.addTarget(self, action: #selector(BalanceViewController.instructionButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    let infoModalButton : UIBarButtonItem? = UIBarButtonItem(customView: infobutton)
    doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(BalanceViewController.doneButtonPressed(_:)))
    doneButton.enabled = false
    
    self.navigationItem.rightBarButtonItems = [doneButton, infoModalButton!]

  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
  {
    var index = self.currentIndex
    
    if(index == 0) || (index == NSNotFound)
    {
      return nil
    }
    index -= 1
    
    return viewControllerAtIndex(index)
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
  {
    var index = self.currentIndex
    if index == NSNotFound
    {
      return nil
    }
    index += 1
    currentIndex = index
    limitIndex = index
    
    if(index == self.pageTitles.count)
    {
      return nil
    }
    currentIndex = index
    
    return viewControllerAtIndex(index)
  }
  
  func viewControllerAtIndex(index: Int) ->BalanceView?
  {
    if self.pageTitles.count == 0 || index >= self.pageTitles.count || index < limitIndex
    {
      return nil
    }
    
    let pageContentViewController = BalanceView(bvc: self)
    pageContentViewController.titleText = pageTitles[index]
    
    return pageContentViewController
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    self.numPages = self.pageTitles.count
    return self.numPages
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return self.currentIndex
  }
  
}

class BalanceView : UITableViewController
{
  var titleText : String = ""
  weak var bvc : BalanceViewController?
//  var timer = 20.00 as Float
//  var count = 0 as Int
  let domFootChoice = ["Left", "Right"]

  init(bvc : BalanceViewController)
  {
    self.bvc = bvc
    
    super.init(style: UITableViewStyle.Grouped)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.tableView.contentInset = UIEdgeInsetsMake(120.0, 0, -120.0, 0)
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    self.tableView.rowHeight = 50.0
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int)->String?
  {
    return titleText
  }
  
  override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
  {
    let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
    header.textLabel?.font = UIFont(name: "Helvetica Neue", size: 20.0)
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    //return self.bvc!.pageTitles.count
    return 9
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
    cell.selectionStyle = UITableViewCellSelectionStyle.None
//    cell.preservesSuperviewLayoutMargins = true
//    cell.contentView.preservesSuperviewLayoutMargins = true
    
    if(indexPath.row == 0)
    {
      //initializeTimer()
      self.bvc!.cellTimerLabel = UILabel(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: 50))
      self.bvc!.cellTimerLabel.text = "What is the athlete's dominant foot?"
      self.bvc!.cellTimerLabel.textAlignment = NSTextAlignment.Center
      self.bvc!.cellTimerLabel.font = UIFont(name: "Helvetica Neue", size: 20.0)
      self.bvc!.cellTimerLabel.userInteractionEnabled = false
      
      cell.contentView.addSubview(self.bvc!.cellTimerLabel)
    }
    
    if(indexPath.row == 1)
    {
      //self.bvc!.domFootSwitch = UISegmentedControl(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: 50))
      self.bvc!.domFootSwitch = UISegmentedControl(items: domFootChoice)
      self.bvc!.domFootSwitch.frame = CGRect(x: self.view.frame.midX-self.view.frame.width/6, y: self.view.frame.minY + 10, width: self.view.frame.width/3, height: 30)
      self.bvc!.domFootSwitch.addTarget(self, action: #selector(BalanceView.domFootSelect(_:)), forControlEvents: .ValueChanged)
      self.bvc!.domFootSwitch.selectedSegmentIndex = self.bvc!.domFootDefault
      
      
      cell.contentView.addSubview(self.bvc!.domFootSwitch)
    }
    
    if(indexPath.row == 3)
    {
      //initializeTimer()
      self.bvc!.cellTimerLabel = UILabel(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: 50))
      self.bvc!.cellTimerLabel.text = String(self.bvc!.timerCount)
      self.bvc!.cellTimerLabel.textAlignment = NSTextAlignment.Center
      self.bvc!.cellTimerLabel.font = UIFont(name: "Helvetica Neue", size: 36.0)
      self.bvc!.cellTimerLabel.userInteractionEnabled = false
      
      cell.contentView.addSubview(self.bvc!.cellTimerLabel)
    }
    
    if(indexPath.row == 4)
    {
      self.bvc!.cellTimerButton = UIButton()
      self.bvc!.cellTimerButton.addTarget(self, action: #selector(BalanceView.timerButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
      self.bvc!.cellTimerButton.frame = CGRectMake(self.view.frame.midX-50, self.view.frame.minY + 10, 100, 40)
      self.bvc!.cellTimerButton.setTitle("Start", forState: .Normal)
      self.bvc!.cellTimerButton.backgroundColor = UIColor.whiteColor()
      self.bvc!.cellTimerButton.setTitleColor(UIColor(rgb: 0x007AFF), forState: .Normal)
      self.bvc!.cellTimerButton.layer.borderWidth = 1
      self.bvc!.cellTimerButton.layer.borderColor = (UIColor(rgb: 0x007AFF)).CGColor
      self.bvc!.cellTimerButton.layer.cornerRadius = 10
      self.bvc!.cellTimerButton.clipsToBounds = true;
      
      cell.contentView.addSubview(self.bvc!.cellTimerButton)
    }
    
    if(indexPath.row == 6)
    {
      self.bvc!.cellCounterLabel = UILabel(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: 50))
      self.bvc!.cellCounterLabel.text = "Number of Errors: \(self.bvc!.count)"
      self.bvc!.cellCounterLabel.textAlignment = NSTextAlignment.Center
      self.bvc!.cellCounterLabel.font = UIFont(name: "Helvetica Neue", size: 24.0)
      self.bvc!.cellCounterLabel.userInteractionEnabled = false
      
      cell.contentView.addSubview(self.bvc!.cellCounterLabel)
    }
    
    if(indexPath.row == 7)
    {
      self.bvc!.cellIncrementButton = UIStepper()
      self.bvc!.cellIncrementButton.wraps = false
      self.bvc!.cellIncrementButton.continuous = false
      self.bvc!.cellIncrementButton.autorepeat = false
      self.bvc!.cellIncrementButton.maximumValue = 10
      self.bvc!.cellIncrementButton.minimumValue = 0
      self.bvc!.cellIncrementButton.addTarget(self, action: #selector(BalanceView.stepperPressed(_:)), forControlEvents: UIControlEvents.ValueChanged)
      self.bvc!.cellIncrementButton.frame = CGRectMake(self.view.frame.midX - 50, self.view.frame.minY, 25, 25)
      
      cell.contentView.addSubview(self.bvc!.cellIncrementButton)
    }
    
    return cell
  }
  
  func timerButtonPressed(sender: UIButton)
  {
    print("timer start")
    self.bvc!.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(BalanceView.timerCountdown), userInfo: nil, repeats: true)
    sender.enabled = false
  }
  
  func stepperPressed(sender: UIStepper)
  {
    //print("It Works, Value is --&gt;\(Int(sender.value).description)")
    self.bvc!.count = Int(sender.value)
    self.bvc!.cellCounterLabel.text = "Number of Errors: \(self.bvc!.count)"
  }
  
  func timerCountdown()
  {
    if self.bvc == nil
    {
    }
    else if(self.bvc!.timerCount > 0) {
      self.bvc!.timerCount -= 0.1
      self.bvc!.cellTimerLabel.text = String(format: "%.1f", self.bvc!.timerCount)
      if(self.bvc!.timerCount < 0.1)
      {
        self.bvc!.timerCount = 0
        self.bvc!.cellTimerLabel.text = "Press Done When Ready"
        self.bvc!.cellTimerLabel.font = UIFont(name: "Helvetica Neue", size: 20.0)
        self.bvc!.doneButton!.enabled = true
        
      }
    }
  }
  
  func domFootSelect(sender: UISegmentedControl)
  {
    switch sender.selectedSegmentIndex {
    case 0:
      self.bvc!.domFoot = "Left"
      self.bvc!.domFootDefault = 0
      print("Left")
    case 1:
      self.bvc!.domFoot = "Right"
      self.bvc!.domFootDefault = 1
      print("Right")
    default:
      print("Default")
      
    }
  }
  
}