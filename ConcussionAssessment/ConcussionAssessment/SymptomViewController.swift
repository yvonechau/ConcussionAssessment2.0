//
//  SymptomViewController.swift
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


class SymptomViewController: UIViewController, UIPageViewControllerDataSource
{
  
  var pageViewController: UIPageViewController?
  
  var pageTitles : Array<String> = ["Headache", "Pressure in Head", "Neck Pain", "Nausea or Vomiting", "Dizziness", "Blurred Vision", "Balance Problems", "Sensitivity to Light", "Sensitivity to Noise", "Feeling Slowed Down", "Feeling like 'in a fog'", "Don't Feel Right", "Difficulty Concentrating", "Difficulty Remembering", "Fatigue or Low Energy", "Confusion", "Drowsiness", "Trouble Falling Asleep", "More Emotional", "Irrability", "Sadness", "Nervous or Anxious"]
  
  var currentIndex : Int = 0
  var limitIndex: Int = 0
  var rowSelected: NSNumber?
  var currScore: NSNumber?
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    pageViewController!.dataSource = self
    
    let startingViewController: SymptomView = viewControllerAtIndex(0)!
//    segCtrller = startingViewController.segCtrl
    let viewControllers = [startingViewController]
    pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
    pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    
    addChildViewController(pageViewController!)
    view.addSubview(pageViewController!.view)
    pageViewController!.didMoveToParentViewController(self)
    
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
  {
    var index = (viewController as! SymptomView).pageIndex

    if(index == 0) || (index == NSNotFound)
    {
      return nil
    }
    index--
    print("back")
    rowSelected = (viewController as! SymptomView).rowSel
    currScore = rowSelected
    print(currScore)
    //currentScore!.numSymptoms = currentScore!.numSymptoms!.integerValue - currScore!.integerValue //SAVE AS AN NSNUMBER
    
    // UNDO VALUE HERE
    return viewControllerAtIndex(index)
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
  {
    var index = (viewController as! SymptomView).pageIndex
    if index == NSNotFound
    {
      return nil
    }
    print("selected passed")
    index++
    currentIndex = index
    limitIndex = index
    if(index == self.pageTitles.count)
    {
      return nil
    }
    
    // SAVE VALUE HERE
    //currentScore!.numSymptoms = //SAVE AS AN NSNUMBER 
    
    
    rowSelected = (viewController as! SymptomView).rowSel
    currScore = rowSelected
    print(currScore)
    print("forward")
    //currentScore!.numSymptoms = currentScore!.numSymptoms!.integerValue - currScore!.integerValue //SAVE AS AN NSNUMBER
    
    currentIndex = index

    return viewControllerAtIndex(index)
  }
  
  func viewControllerAtIndex(index: Int) ->SymptomView?
  {
    if self.pageTitles.count == 0 || index >= self.pageTitles.count || index < limitIndex
    {
      return nil
    }
  
    let pageContentViewController = SymptomView(pvc: self)
    pageContentViewController.titleText = pageTitles[index]
    pageContentViewController.pageIndex = index

    return pageContentViewController
  }
  
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return self.pageTitles.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return 0
  }
  
}

class SymptomView: UITableViewController
{
  var pageIndex : Int = 0
  var titleText : String = ""
  var rowSel : NSNumber = 0
  var selected : Int? = 0
  
  let LabelArray = ["None", "Less Mild", "Mild", "Less Moderate", "Moderate", "Less Severe", "Severe"]
  
  weak var pvc : SymptomViewController?
  init(pvc : SymptomViewController)
  {
    self.pvc = pvc
    super.init(style: UITableViewStyle.Grouped)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
//    let title = UILabel(frame: CGRectMake(0,0, view.frame.width, 50))
//    title.textColor = UIColor.blackColor()
//    title.text = " Symptom Evaluation"
//    title.font = title.font.fontWithSize(17)
//    title.textAlignment = .Left
//    title.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
//    view.addSubview(title)

    
    self.tableView.contentInset = UIEdgeInsetsMake(120.0, 0, -120.0, 0)
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
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
  

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return LabelArray.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MenuCell")
    
    Cell.textLabel?.text = LabelArray[indexPath.row]
    Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    return Cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    rowSel = indexPath.item
    selected = 1
    print(selected)
    pageIndex++
    print(pageIndex)
    let startingViewController: SymptomView = self.pvc!.viewControllerAtIndex(pageIndex)!
    //    segCtrller = startingViewController.segCtrl
    let viewControllers = [startingViewController]

    self.pvc!.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
  }
  
}