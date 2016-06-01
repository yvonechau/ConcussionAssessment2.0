//
//  TablePageViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

// TODO: https://github.com/lanqy/swift-programmatically, add the progressbar instead?
// change selections to text
// OR gradient
// tab go to next screen

import UIKit


class TablePageViewController: UIViewController, UIPageViewControllerDataSource
{
  var pageViewController: UIPageViewController?
  var testName: String
  var pageTitles : Array<String>
  var labelArray : Array<Array<String>>
  var currentIndex : Int = 0
  var limitIndex: Int = 0
  var rowSelected: NSNumber?
  var totalRows: Int = 0
  var donePressed: Bool = false
  var instructions: String
  var next: UIViewController?
  var original: UIViewController?
  var startingViewController : TablePageView?
  var numTrials : [Int]?
  var singlePage: BooleanType
  
  var numPages: Int
  var numSelected: NSNumber
  var currScore: NSNumber
  
  init(pageTitles : Array<String>, labelArray: Array<Array<String>>, testName : String, instructionPage : TablePageView?, instructions: String, next: TablePageViewController?, original: UIViewController?, numTrials: [Int]?, singlePage: BooleanType)
  {
    self.pageTitles = pageTitles
    self.labelArray = labelArray
    self.testName = testName
    self.startingViewController = instructionPage
    self.instructions = instructions
    self.next = next
    self.original = original!
    self.numTrials = numTrials
    self.singlePage = singlePage
    self.numPages = 0
    self.numSelected = 0
    self.currScore = 0
    super.init(nibName:nil, bundle:nil)
  }
  
  init(pageTitles : Array<String>, labelArray: Array<Array<String>>, testName : String, instructionPage : TablePageView?, instructions: String, nextBalance: BalanceViewController?, original: UIViewController?, numTrials: [Int]?, singlePage: BooleanType)
  {
    self.pageTitles = pageTitles
    self.labelArray = labelArray
    self.testName = testName
    self.startingViewController = instructionPage
    self.instructions = instructions
    self.next = nextBalance //for when the next test is BESS
    self.original = original!
    self.numTrials = numTrials
    self.singlePage = singlePage
    self.numPages = 0
    self.numSelected = 0
    self.currScore = 0
    super.init(nibName:nil, bundle:nil)
  }

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setNextTest(next: TablePageViewController?)
  {
    self.next = next
  }
  
  func buttonPressed(sender: UIButton)
  {
    let alertView = UIAlertController(title: "Instructions", message: self.instructions, preferredStyle: UIAlertControllerStyle.Alert)
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

  
  func setScore()
  {
    switch self.testName
    {
    case "Symptom Evaluation":
      self.currScore = Int(self.currScore) + Int(self.rowSelected!)

      if self.rowSelected != 0
      {
        self.numSelected = Int(self.numSelected) + Int(1)
        print(self.rowSelected)
      }
      
      if self.currentIndex == self.numPages
      {
        database.setSeverity(currentScoreID!, score: self.currScore)
        database.setNumSymptoms(currentScoreID!, score: self.numSelected)
      }
    case "Glasgow Coma Scale":
      self.currScore = Int(self.currScore) + Int(self.rowSelected!) + 1
      
      if self.currentIndex == self.numPages
      {
        database.setGlasgow(currentScoreID!, score: self.currScore)
      }
      
    case "Maddocks Test":
      self.currScore = Int(self.currScore) + Int(self.rowSelected!)
      
      if self.currentIndex == self.numPages
      {
        database.setMaddocks(currentScoreID!, score: self.currScore)
      }
      
    case "Cognitive Assessment: Orientation":
      self.currScore = Int(self.currScore) + Int(self.rowSelected!)
      
      if self.currentIndex == self.numPages
      {
        database.setOrientation(currentScoreID!, score: self.currScore)
      }
      
    case "Cognitive Assessment: Immediate Memory": // Need to be checked for trial reboots
      self.currScore = Int(self.totalRows)
      if self.donePressed
      {
        if database.scoreWithID(currentScoreID!)[0].immediateMemory != nil
        {
            database.setImmMemory(currentScoreID!, score: Int(self.currScore) + Int(database.scoreWithID(currentScoreID!)[0].immediateMemory!))
        }
        else
        {
            database.setImmMemory(currentScoreID!, score: self.currScore)
        }
        print(database.scoreWithID(currentScoreID!)[0].immediateMemory)
        self.donePressed = false
      }
      
    case "Cognitive Assessment: Digits Backwards":
      self.currScore = Int(self.currScore) + Int(self.rowSelected!)
      
      if self.currentIndex == self.numPages
      {
        database.setConcentration(currentScoreID!, score: self.currScore)
      }
      
    case "Cognitive Assessment: Months in Reverse Order":
      self.currScore = Int(self.currScore) + Int(self.rowSelected!)
      
      if self.currentIndex == self.numPages
      {
        database.setConcentration(currentScoreID!, score: self.currScore)
        
        //database.setConcentration(currentScoreID!, score: database.getConcentration() + self.pvc!.currScore)
      }
    case "SAC Delayed Recall": // Need to be checked for trial reboots
      self.currScore = Int(self.totalRows)
      if self.donePressed
      {
        print(self.totalRows)

        database.setDelayedRecall(currentScoreID!, score: self.currScore)
       
        self.donePressed = false
      }
    case "Balance Examination":
      print("balance score")
      
    default: print("none")
    }
    
  }

  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    pageViewController!.dataSource = self

    for view in pageViewController!.view.subviews{
      if let subView = view as? UIScrollView{
        subView.scrollEnabled = false
      }
    }
    
    if(self.startingViewController == nil) // not instantiated so it has no instruction page
    {
        self.startingViewController = viewControllerAtIndex(0)!
    }
    
    let viewControllers = [self.startingViewController!]
    
    pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
    pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - (self.tabBarController!.tabBar.frame.size.height));
//    pageViewController!.contentInset = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.size.height)!, 0, -(self.tabBarController!.tabBar.frame.size.height), 0)

//
//    if self.singlePage
//    {
//      print(self.testName)
//        pageViewController!.view.frame = CGRectMake(0, (self.navigationController?.navigationBar.frame.size.height)! - self.tabBarController!.tabBar.frame.size.height, view.frame.size.width, view.frame.size.height-self.tabBarController!.tabBar.frame.size.height - 50);
//    }
//    //
    //    let subviews = pageViewController!.view.subviews
    //
    //    var thisControl: UIPageControl! = nil
    //
    //    for s in subviews
    //    {
    //      if let pc = s as? UIPageControl
    //      {
    //        thisControl = pc
    //      }
    //    }
    //
    //    thisControl.bounds.insetInPlace(dx: 0, dy: -500)
    //    
    

    
    
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

    infobutton.addTarget(self, action: #selector(TablePageViewController.buttonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    let infoModalButton : UIBarButtonItem? = UIBarButtonItem(customView: infobutton)
    
    
    
    self.navigationItem.rightBarButtonItems = [infoModalButton!]
    

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
    //print("selected passed")
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
  
  func viewControllerAtIndex(index: Int) ->TablePageView?
  {
    if self.pageTitles.count == 0 || index >= self.pageTitles.count || index < limitIndex
    {
      return nil
    }
    
    let pageContentViewController = TablePageView(pvc: self)
    pageContentViewController.titleText = pageTitles[index]
    
    return pageContentViewController
  }
  
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    if self.singlePage
    {
      if self.numTrials != nil
      {
        self.numPages = self.numTrials![1]
      }
      else
      {
        print("here")
        self.numPages = 1
      }
      
    }
    else
    {
      self.numPages = self.pageTitles.count

    }
    return self.numPages
    
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return self.currentIndex
  }
  
}

class TablePageView: UITableViewController
{
  var titleText : String = ""
  var rowSel : NSNumber = 0

  var totalRowsSelected : Int = 0
  var checked : [Bool]
  weak var pvc : TablePageViewController?
  let LabelArray : Array<Array<String>>

  
  init(pvc : TablePageViewController)
  {
    self.pvc = pvc
    
    self.LabelArray = pvc.labelArray
    self.checked = [Bool](count: self.pvc!.pageTitles.count, repeatedValue: false)
    super.init(style: UITableViewStyle.Grouped)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setPVC(pvc : TablePageViewController?)
  {
    self.pvc = pvc!
  }
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.tableView.frame = CGRectMake(0, 0, self.pvc!.view.frame.size.width, self.pvc!.view.frame.size.height);

    self.tableView.contentInset = UIEdgeInsetsMake((self.pvc!.navigationController?.navigationBar.frame.size.height)! + 40, 0, -(self.pvc!.tabBarController!.tabBar.frame.size.height), 0)
    self.tableView.scrollIndicatorInsets.bottom = -(self.pvc!.tabBarController!.tabBar.frame.size.height)
    self.tableView.scrollIndicatorInsets.top = (self.pvc!.navigationController?.navigationBar.frame.size.height)! + 40

    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    self.tableView.rowHeight = 50.0

  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int)->String?
  {
    if(self.pvc!.singlePage)
    {
        if section == 1
        {
          return ""
        }
        else{

        
        if(self.pvc!.numTrials != nil)
        {
          return "Trial \(self.pvc!.numTrials![0] + 1)/\(self.pvc!.numTrials![1]):"
        }
        else
        {
          return "Trial 1:"
        }
      }
    }
    else{
      return titleText
    }


  }
  
  override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
  {
    let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
    
    header.textLabel?.font = UIFont(name: "Helvetica Neue", size: 20.0)

  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    
    if self.pvc!.singlePage
    {
      return 2
    }
    else{
      return 1
    }
    
  }
  
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    if(self.pvc!.singlePage)
    {
      
      if section == 1{
        return 1
      }
      else
      {
        return self.pvc!.pageTitles.count
      }
    }
    else
    {
      if self.pvc!.currentIndex < self.pvc!.numPages
      {
        return LabelArray[self.pvc!.currentIndex].count
      }
      else
      {
        return 1
      }
    }
    
   
  }
  
  
  
  func doneButtonPressed(sender: UIButton)
  {
    print("meep")
    self.pvc!.donePressed = true
    self.pvc!.setScore()
    self.pvc!.currentIndex += 1
    if(self.pvc!.numTrials != nil && self.pvc!.numTrials![0] < self.pvc!.numTrials![1] - 1) // increase the current trial it is on when done button is pressed if there are trials
    {
      self.pvc!.numTrials![0] += 1
      self.pvc!.currentIndex = self.pvc!.numTrials![0] //changes pagination dots to current trial
      self.pvc!.totalRows = 0 //resets trial score back to 0
      let startingViewController: TablePageView = self.pvc!.viewControllerAtIndex(self.pvc!.currentIndex)!
      let viewControllers = [startingViewController]
      self.pvc!.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
    }
    else
    {
      if(self.pvc!.next == nil) //end of test
      {
        if (self.navigationController?.topViewController!.isKindOfClass(ScoreBoardController) != nil)
        {
            //self.navigationController?.popToViewController(self.original!, animated: true)
            let scoreboard = ScoreBoardController(originalPage: self.pvc!.original!)
            self.view.userInteractionEnabled = false
            self.navigationController?.pushViewController(scoreboard, animated: true)
            self.view.userInteractionEnabled = true
          

                    }
      }
      else if(self.pvc!.next != nil)
      {
        print("next, normal controller")
        self.view.userInteractionEnabled = false
        self.navigationController?.pushViewController(self.pvc!.next!, animated: true)
        self.view.userInteractionEnabled = true
      }
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    
    
      let Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MenuCell")
      
            
      if(self.pvc!.singlePage)
      {
        if indexPath.section == 1
        {
          let Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "PickerCell")
          
          let doneButton = UIButton(frame: CGRectMake(self.tableView.frame.size.width / 2 - 50, 0, 100, self.tableView.rowHeight))
          doneButton.addTarget(self, action: #selector(TablePageView.doneButtonPressed(_:)), forControlEvents: .TouchUpInside)
          
          doneButton.setTitle("Done", forState: .Normal)
          doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
          
          doneButton.backgroundColor = UIColor.whiteColor()
          doneButton.setTitleColor(UIColor(rgb: 0x007AFF), forState: .Normal)
          doneButton.layer.borderWidth = 1
          doneButton.layer.borderColor = (UIColor(rgb: 0x007AFF)).CGColor
          doneButton.layer.cornerRadius = 10
          doneButton.clipsToBounds = true
          Cell.contentView.addSubview(doneButton)
          Cell.backgroundColor = UIColor.clearColor()
          
          return Cell
          
        }
        else
        {
          if(!checked[indexPath.row])
          {
            Cell.accessoryType = .None
          }
          else if(checked[indexPath.row])
          {
            Cell.accessoryType = UITableViewCellAccessoryType.Checkmark
          }
          Cell.textLabel?.text = self.pvc!.pageTitles[indexPath.row]
        
        }
      }
      else{
        if(self.pvc!.currentIndex < self.pvc!.numPages)
        {
            Cell.textLabel?.text = LabelArray[self.pvc!.currentIndex][indexPath.row]
        }
        
        Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
      }
      return Cell

    }
  
  
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    
    
    
    rowSel = indexPath.item
    self.pvc!.rowSelected = rowSel
    self.pvc!.currentIndex += 1 //updates dots
    self.pvc!.setScore()
    
    if(self.pvc!.singlePage) // all words on one page
    {
      if let cell = tableView.cellForRowAtIndexPath(indexPath) // for toggling checkmarks
      {
        if(cell.accessoryType == .Checkmark)
        {
          cell.accessoryType = .None
          checked[indexPath.row] = false
          self.totalRowsSelected -= 1 // gets reset at start of each trial

        }
        else
        {
          cell.accessoryType = .Checkmark
          checked[indexPath.row] = true
          self.totalRowsSelected += 1 // need to check when done
        }
      }
      self.pvc!.totalRows = self.totalRowsSelected
      self.pvc!.setScore()
    }
    else
    {
        if(self.pvc!.numTrials != nil) //no all rows, but has trials
        {
          if(indexPath.item == 0) // incorrect
          {
            
            if(self.pvc!.numTrials![1] == 2) // if the number of trials increased to two
            {
              self.pvc!.view.userInteractionEnabled = false
              self.pvc!.navigationController?.pushViewController(self.pvc!.next!, animated: true)
              self.pvc!.view.userInteractionEnabled = true

            }
            else //increase number of total trials if you get the first one wrong, goes to trial 2
            {
              self.pvc!.currentIndex = 0
              let startingViewController: TablePageView = self.pvc!.viewControllerAtIndex(self.pvc!.currentIndex)!
              let viewControllers = [startingViewController]
              self.pvc!.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
              self.pvc!.numTrials![1] += 1
            }
          }
         }

        if(self.pvc!.next == nil) //single test or end of sequence of test
        {
          if(self.pvc!.currentIndex == self.pvc!.pageTitles.count || self.pvc!.pageTitles.count == 1) // end of test
          {
            print("End Test")
           // self.pvc!.navigationController?.popToViewController(self.pvc!.original!, animated: true)
            //self.navigationController?.popToRootViewControllerAnimated(true);
            
            let scoreboard = ScoreBoardController(originalPage: self.pvc!.original!)
            
            self.pvc!.view.userInteractionEnabled = false
            self.pvc!.navigationController?.pushViewController(scoreboard, animated: true)
            self.pvc!.view.userInteractionEnabled = true
            
          }
          else // still pages left
          {
            print("More Pages")
            let startingViewController: TablePageView = self.pvc!.viewControllerAtIndex(self.pvc!.currentIndex)!
            let viewControllers = [startingViewController]
            self.pvc!.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
          }

        }
        else if(self.pvc!.next != nil) // still tests next
        {
          if(self.pvc!.currentIndex == self.pvc!.pageTitles.count)
          {
            self.pvc!.view.userInteractionEnabled = false
            self.pvc!.navigationController?.pushViewController(self.pvc!.next!, animated: true)
            self.pvc!.view.userInteractionEnabled = true
            
          }
          else
          {
          
            let startingViewController: TablePageView = self.pvc!.viewControllerAtIndex(self.pvc!.currentIndex)!
            let viewControllers = [startingViewController]
            self.pvc!.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
          }
          
        }
    }
  }
}
