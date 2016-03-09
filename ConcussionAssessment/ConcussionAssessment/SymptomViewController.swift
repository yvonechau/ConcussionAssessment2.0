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
  var segCtrller: UISegmentedControl?
  
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
//    segCtrller = (viewController as! SymptomView).segCtrl
    currScore = segCtrller!.selectedSegmentIndex
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
    index++
    limitIndex = index
    if(index == self.pageTitles.count)
    {
      return nil
    }
    
    // SAVE VALUE HERE
    //currentScore!.numSymptoms = //SAVE AS AN NSNUMBER 
    
//    currScore = segCtrller!.selectedSegmentIndex
//    print("%s%d", "FOR", currScore!)
    
    //currentScore!.numSymptoms = currentScore!.numSymptoms!.integerValue + currScore!.integerValue //SAVE AS AN NSNUMBER

//    print(segCtrller!.selectedSegmentIndex)
    print("forward")

    return viewControllerAtIndex(index)
  }
  
  func viewControllerAtIndex(index: Int) ->SymptomView?
  {
    if self.pageTitles.count == 0 || index >= self.pageTitles.count || index < limitIndex
    {
      return nil
    }
    
    let pageContentViewController = SymptomView()
    pageContentViewController.titleText = pageTitles[index]
    pageContentViewController.pageIndex = index
    currentIndex = index
    
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
  
  let LabelArray = ["None", "Mild", "Less Moderate", "Moderate", "Less Severe", "Severe"]

  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    self.title = titleText
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return LabelArray.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let Cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MenuCell")
    
    Cell.textLabel?.text = LabelArray[indexPath.row]
    Cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    
    return Cell
  }
  
//  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    switch(indexPath.item) {
//    case 0:
//      let MaddocksView = MaddocksViewController() as MaddocksViewController
//      self.navigationController?.pushViewController(MaddocksView, animated: true)
//    case 1:
//      let pageControl = UIPageControl.appearance()
//      pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
//      pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
//      pageControl.backgroundColor = UIColor.whiteColor()
//      let SymptomView = SymptomViewController() as SymptomViewController
//      self.navigationController?.pushViewController(SymptomView, animated: true)
//    case 2:
//      let CognitiveView = CognitiveTableViewController() as CognitiveTableViewController
//      self.navigationController?.pushViewController(CognitiveView, animated: true)
//    case 3:
//      let BalanceView = BalanceViewController() as BalanceViewController
//      self.navigationController?.pushViewController(BalanceView, animated: true)
//    default:
//      fatalError("Unknown test choice.")
//      
//    }
//  }
}