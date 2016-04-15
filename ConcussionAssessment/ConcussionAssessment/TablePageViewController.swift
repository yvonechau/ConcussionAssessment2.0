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
  var currScore: NSNumber?
  var instructions: String
  var next: TablePageViewController?
  var original: UIViewController?
  var startingViewController : TablePageView?
  var numTrials : [Int]?
  var firstPage: BooleanType
  
  init(pageTitles : Array<String>, labelArray: Array<Array<String>>, testName : String, instructionPage : TablePageView?, instructions: String, next: TablePageViewController?, original: UIViewController?, numTrials: [Int]?, firstPage: BooleanType)
  {
    self.pageTitles = pageTitles
    self.labelArray = labelArray
    self.testName = testName
    self.startingViewController = instructionPage
    self.instructions = instructions
    self.next = next
    self.original = original!
    self.numTrials = numTrials
    print(numTrials)
    self.firstPage = firstPage
    super.init(nibName:nil, bundle:nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
  
  func doneButtonPressed(sender: UIButton)
  {
    print("here")
    print(self.numTrials)
    self.numTrials![0] += 1
    if(self.numTrials != nil && self.numTrials![0] <= self.numTrials![1] - 1)
    {
      
      self.currentIndex = 0
      let startingViewController: TablePageView = self.viewControllerAtIndex(self.currentIndex)!
      let viewControllers = [startingViewController]
      print(self.numTrials![0])
      self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
    }
    else
    {
      if(self.next == nil) //end of test
      {
        self.navigationController?.popToViewController(self.original!, animated: true)
      }
      else if(self.next != nil)
      {
        self.navigationController?.pushViewController(self.next!, animated: true)
      }
    }

  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    pageViewController!.dataSource = self
    
    let doneModalButton : UIBarButtonItem?

    
    if(self.startingViewController == nil) // not instantiated so it has no instrution page
    {
        self.startingViewController = viewControllerAtIndex(0)!
    }
    
    let viewControllers = [self.startingViewController!]
    pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
    pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    self.navigationItem.title = self.testName
    
    addChildViewController(pageViewController!)
    view.addSubview(pageViewController!.view)
    pageViewController!.didMoveToParentViewController(self)
    let infobutton = UIButton(type: UIButtonType.InfoDark)

    infobutton.addTarget(self, action: #selector(TablePageViewController.buttonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    let infoModalButton : UIBarButtonItem? = UIBarButtonItem(customView: infobutton)
    
    if(self.firstPage)
    {
      let doneButton = UIButton()
      doneButton.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
      doneButton.setTitle("Done", forState: .Normal)
      doneButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
      print("done")
      doneButton.addTarget(self, action: #selector(TablePageViewController.doneButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
      doneModalButton = UIBarButtonItem(customView: doneButton)
      self.navigationItem.rightBarButtonItems = [doneModalButton!, infoModalButton!]
    }
    else
    {
      self.navigationItem.rightBarButtonItems = [infoModalButton!]
    }

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
    
    self.rowSelected = (viewController as! TablePageView).rowSel
    currScore = self.rowSelected
    //print(currScore)
    
    //currentScore!.numSymptoms = currentScore!.numSymptoms!.integerValue - currScore!.integerValue //SAVE AS AN NSNUMBER
    
    // UNDO VALUE HERE
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
    
    // SAVE VALUE HERE
    //currentScore!.numSymptoms = //SAVE AS AN NSNUMBER
    
    
    rowSelected = (viewController as! TablePageView).rowSel
    currScore = rowSelected
    //print(currScore)
    //print("forward")
    //currentScore!.numSymptoms = currentScore!.numSymptoms!.integerValue - currScore!.integerValue //SAVE AS AN NSNUMBER
    
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
    return self.pageTitles.count
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
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    self.tableView.contentInset = UIEdgeInsetsMake(120.0, 0, -120.0, 0)
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
    if(self.pvc!.firstPage)
    {
      if(self.pvc!.numTrials != nil)
      {
        return "Trial \(self.pvc!.numTrials![0] + 1)/\(self.pvc!.numTrials![1]):"
      }
      else
      {
        return "Trial 1:"
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
  
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    if(self.pvc!.firstPage)
    {
     return self.pvc!.pageTitles.count
    }
    else
    {
     return LabelArray[self.pvc!.currentIndex].count
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MenuCell")
    

    Cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 18.0)
    
    if(self.pvc!.firstPage)
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
    else{
      Cell.textLabel?.text = LabelArray[self.pvc!.currentIndex][indexPath.row]
      Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    return Cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    rowSel = indexPath.item
    self.pvc!.currentIndex += 1 //updates dots

    if(self.pvc!.firstPage) // all words on one page
    {
      if let cell = tableView.cellForRowAtIndexPath(indexPath) // for toggling checkmarks
      {
        if(cell.accessoryType == .Checkmark)
        {
          cell.accessoryType = .None
          checked[indexPath.row] = false
        }
        else
        {
          cell.accessoryType = .Checkmark
          checked[indexPath.row] = true
          self.totalRowsSelected += 1

        }
        print(self.totalRowsSelected)
        
      }
    }
    else
    {
        if(self.pvc!.next == nil) //end of test
        {
          self.pvc!.navigationController?.popToViewController(self.pvc!.original!, animated: true)
        }
        else if(self.pvc!.next != nil)
        {
          if(self.pvc!.currentIndex == self.pvc!.pageTitles.count - 1)
          {
              self.pvc!.navigationController?.pushViewController(self.pvc!.next!, animated: true)
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
