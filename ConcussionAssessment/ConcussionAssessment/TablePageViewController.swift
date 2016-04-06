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
  
  
  
  var pageTitles : Array<String>
  var currentIndex : Int = 0
  var limitIndex: Int = 0
  var rowSelected: NSNumber?
  var currScore: NSNumber?
  
  init(pageTitles : Array<String>)
  {
    self.pageTitles = pageTitles

    super.init(nibName:nil, bundle:nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    pageViewController!.dataSource = self
    
    let startingViewController: TablePageView = viewControllerAtIndex(0)!
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
    var index = (viewController as! TablePageView).pageIndex
    
    if(index == 0) || (index == NSNotFound)
    {
      return nil
    }
    index -= 1
    
    rowSelected = (viewController as! TablePageView).rowSel
    currScore = rowSelected
    print(currScore)
    
    //currentScore!.numSymptoms = currentScore!.numSymptoms!.integerValue - currScore!.integerValue //SAVE AS AN NSNUMBER
    
    // UNDO VALUE HERE
    return viewControllerAtIndex(index)
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
  {
    var index = (viewController as! TablePageView).pageIndex
    if index == NSNotFound
    {
      return nil
    }
    print("selected passed")
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
    print(currScore)
    print("forward")
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
    pageContentViewController.pageIndex = index
    
    return pageContentViewController
  }
  
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return self.pageTitles.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    print("current index: %d", self.currentIndex)
    return self.currentIndex
  }
  
}

class TablePageView: UITableViewController
{
  var pageIndex : Int = 0
  var titleText : String = ""
  var rowSel : NSNumber = 0
  var selected : Int? = 0
  
  let LabelArray = ["None", "Less Mild", "Mild", "Less Moderate", "Moderate", "Less Severe", "Severe"]
  
  weak var pvc : TablePageViewController?
  init(pvc : TablePageViewController)
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
    pageIndex += 1
    self.pvc!.currentIndex += 1 //updates dots
    
    if(self.pvc!.currentIndex == self.pvc!.pageTitles.count - 1)
    {
      print("next")
    }
    
    print(self.pvc!.pageTitles.count)
    let startingViewController: TablePageView = self.pvc!.viewControllerAtIndex(pageIndex)!
    //    segCtrller = startingViewController.segCtrl
    let viewControllers = [startingViewController]
    
    self.pvc!.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
    //self.pvc!.pageViewController!.currentPage +=1
    
  }
  
}