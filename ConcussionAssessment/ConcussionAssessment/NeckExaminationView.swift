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
    pageViewController!.view.frame = CGRectMake(0, (self.navigationController?.navigationBar.frame.size.height)! - self.tabBarController!.tabBar.frame.size.height, view.frame.size.width, view.frame.size.height-self.tabBarController!.tabBar.frame.size.height);
    //
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
    
    self.navigationItem.prompt = self.testName
    self.title = self.pageTitles[self.currentIndex]
    
    
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
  
  
init(nvc : NeckExamViewController)
  {
    self.nvc = nvc
    self.pageContent = nvc.pageContent
    self.textField = UITextField()

    super.init(style: UITableViewStyle.Grouped)

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func buttonPressed(sender: UIButton)
  {
    self.nvc!.currentIndex += 1
    if self.nvc!.currentIndex == self.pageContent.count
    {
      self.navigationController?.popToViewController(self.nvc!.original!, animated: true)
    }
    else{
      let startingViewController: NeckExamView = self.nvc!.viewControllerAtIndex(self.nvc!.currentIndex)!
      let viewControllers = [startingViewController]
      self.nvc!.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
      print(self.nvc!.pageTitles[self.nvc!.currentIndex])
      self.nvc!.navigationItem.title = self.nvc!.pageTitles[self.nvc!.currentIndex]

    }
    
  }
  
  
  override func viewDidLoad()
  {
    self.tableView.contentInset = UIEdgeInsetsMake(80.0, 0, -120.0, 0)
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    self.tableView.rowHeight = 50.0

    //let doneButton = UIButton(frame: CGRectMake(view.frame.width/2 - 50, view.frame.height - 230, 100, 70))
    //doneButton.actionsForTarget(target: AnyObject?, forControlEvent: UIControlEvents)

    let doneButton = UIButton(frame: CGRectMake(view.frame.width/2 - 50, view.frame.height - 230, 100, 60))
    doneButton.addTarget(self, action: #selector(NeckExamView.buttonPressed(_:)), forControlEvents: .TouchUpInside)

    doneButton.setTitle("Done", forState: .Normal)
    doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    doneButton.backgroundColor =  UIColor(rgb: 0x002855)

    self.tableView.addSubview(doneButton)
    
    super.viewDidLoad()
  }
 
  // Data Source Methods
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
  {
    return pageContent[nvc!.currentIndex][pickerView.tag].count - 1

  }
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
  {
    return pageContent[nvc!.currentIndex][pickerView.tag][row]
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    print("here")
    print(self.nvc!.pageContent.count)
    print(self.nvc!.currentIndex)
    return self.pageContent[self.nvc!.currentIndex].count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return 1
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int)->String?
  {
    let sectionHeader = self.pageContent[self.nvc!.currentIndex][section]

    return sectionHeader[sectionHeader.count - 1]
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
  {
    return 60
  }


 //called for how many rows in a section
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "PickerCell")
    let pickerView: UIPickerView = UIPickerView(frame: CGRectMake(10, -20, 200, 100))
    pickerView.tag = indexPath.section
    pickerView.dataSource = self
    pickerView.delegate = self
    Cell.contentView.addSubview(pickerView)
    return Cell
  }
  
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    
  }
}

class PickerCell: UITableViewCell
{
  
}