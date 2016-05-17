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


class NeckExamViewController: UIViewController, UIPageViewControllerDataSource
{
  var pageViewController: UIPageViewController?
  var testName: String
  var pageTitles : Array<String>
  var pageContent : [[[String]]]
  var currentIndex : Int = 0
  var limitIndex: Int = 0
  var rowSelected: NSNumber?
  var totalRows: Int = 0
  var donePressed: Bool = false
  var instructions: String
  var next: UIViewController?
  var original: UIViewController?
  var startingViewController : NeckExamView?
  
  var numPages: Int
  var numSelected: NSNumber
  var currScore: NSNumber
  
  init(pageTitles : Array<String>, pageContent: [[[String]]], testName : String, instructions: String, next: UIViewController?, original: UIViewController?, numTrials: [Int]?, singlePage: BooleanType)
  {
    self.pageTitles = pageTitles
    self.testName = testName
    self.pageContent = pageContent
    self.instructions = instructions
    self.next = next
    self.original = original!
    self.numPages = 0
    self.numSelected = 0
    self.currScore = 0
    super.init(nibName:nil, bundle:nil)
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    fatalError("init(coder:) has not been implemented")
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
  
  func viewControllerAtIndex(index: Int) ->NeckExamView?
  {
    if self.pageTitles.count == 0 || index >= self.pageTitles.count || index < limitIndex
    {
      return nil
    }
    
    let pageContentViewController = NeckExamView(nvc: self)
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

class NeckExamView: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate
{

  weak var nvc : NeckExamViewController?
  let pageContent : [[[String]]]
  var titleText : String = ""
  
  var textField: UITextField
  var pickerView: UIPickerView
  
  
init(nvc : NeckExamViewController)
  {
    self.nvc = nvc
    self.pageContent = nvc.pageContent
    self.textField = UITextField()
    self.pickerView = UIPickerView()
    
    super.init(style: UITableViewStyle.Grouped)
    self.pickerView.dataSource = self
    self.pickerView.delegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad()
  {
    self.tableView.contentInset = UIEdgeInsetsMake(120.0, 0, -120.0, 0)
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    self.tableView.rowHeight = 50.0

    super.viewDidLoad()
  }
  
  // Data Source Methods
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
  {
    return self.pageContent[self.nvc!.currentIndex].count
  }
  
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    print(pageContent[self.nvc!.currentIndex])
    return self.pageContent[self.nvc!.currentIndex].count
  }
  
  //called for how many rows in a section
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MenuCell")
    
    
      Cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 18.0)
      Cell.accessoryType = UITableViewCellAccessoryType.None
      let cellContent = self.pageContent[self.nvc!.currentIndex][indexPath.row]
      print(cellContent[indexPath.row])
      Cell.textLabel?.text = cellContent[cellContent.count - 1]
    
    
    return Cell
  }
  
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
  }
}
