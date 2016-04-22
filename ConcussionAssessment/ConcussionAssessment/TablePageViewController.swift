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
  
  var instructions: String
  var next: TablePageViewController?
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
  
  func doneButtonPressed(sender: UIButton)
  {
    if(self.numTrials != nil && self.numTrials![0] < self.numTrials![1] - 1) // increase the current trial it is on when done button is pressed if there are trials
    {
      self.numTrials![0] += 1

      self.currentIndex = 0
      let startingViewController: TablePageView = self.viewControllerAtIndex(self.currentIndex)!
      let viewControllers = [startingViewController]
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

    infobutton.addTarget(self, action: #selector(TablePageViewController.buttonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    let infoModalButton : UIBarButtonItem? = UIBarButtonItem(customView: infobutton)
    
    
    if(self.singlePage)
    {
      let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(TablePageViewController.doneButtonPressed(_:)))
      self.navigationItem.rightBarButtonItems = [doneButton, infoModalButton!]
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
        return self.numTrials![1]
      }
      else
      {
        print("here")
        return 1
      }
      
    }
    else
    {
      return self.pageTitles.count

    }
    
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
    if(self.pvc!.singlePage)
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
    if(self.pvc!.singlePage)
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
    
    if(self.pvc!.singlePage)
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
    }
    else
    {
        if(self.pvc!.numTrials != nil) //no all rows, but has trials
        {
          if(indexPath.item == 1) // incorrect
          {
            
            if(self.pvc!.numTrials![1] == 2) // if the number of trials increased to two
            {
              self.pvc!.navigationController?.pushViewController(self.pvc!.next!, animated: true)

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
            self.pvc!.navigationController?.popToViewController(self.pvc!.original!, animated: true)
          }
          else // still pages left
          {
            let startingViewController: TablePageView = self.pvc!.viewControllerAtIndex(self.pvc!.currentIndex)!
            let viewControllers = [startingViewController]
            self.pvc!.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
          }

        }
        else if(self.pvc!.next != nil) // still tests next
        {
          if(self.pvc!.currentIndex == self.pvc!.pageTitles.count)
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
