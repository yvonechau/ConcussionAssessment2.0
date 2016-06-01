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
    self.instructions = "Select the correct option for each neck section."
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
    pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - (self.tabBarController!.tabBar.frame.size.height));
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
  var cellArray: [UITableViewCell]
  
init(nvc : NeckExamViewController)
  {
    self.nvc = nvc
    self.pageContent = nvc.pageContent
    self.textField = UITextField()
    self.cellArray = []
    super.init(style: UITableViewStyle.Grouped)

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func buttonPressed(sender: UIButton)
  {
    self.setScore()

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
    self.tableView.frame = CGRectMake(0, (self.nvc!.navigationController?.navigationBar.frame.size.height)! - self.nvc!.tabBarController!.tabBar.frame.size.height, self.nvc!.view.frame.size.width, self.tableView.frame.size.height-self.nvc!.tabBarController!.tabBar.frame.size.height);

    self.tableView.contentInset = UIEdgeInsetsMake((self.nvc!.navigationController?.navigationBar.frame.size.height)! + 40, 0, -(self.nvc!.tabBarController!.tabBar.frame.size.height), 0)
    self.tableView.scrollIndicatorInsets.bottom = -(self.nvc!.tabBarController!.tabBar.frame.size.height)
    self.tableView.scrollIndicatorInsets.top = (self.nvc!.navigationController?.navigationBar.frame.size.height)! + 40
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    self.tableView.rowHeight = 70
    self.tableView.allowsSelection = false
    //let doneButton = UIButton(frame: CGRectMake(view.frame.width/2 - 50, view.frame.height - 230, 100, 70))
    //doneButton.actionsForTarget(target: AnyObject?, forControlEvent: UIControlEvents)
    
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
  
  func setScore(){
    print("moop")
    print(self.pageContent[self.nvc!.currentIndex])
    for Cell in cellArray
    {
      for s in (Cell.contentView.subviews)
      {
        if s.isKindOfClass(UIPickerView)
        {
          let pv = s as! UIPickerView
          print(pageContent[nvc!.currentIndex][pv.tag][pv.selectedRowInComponent(0)])
          
        }
      }
    
    


    
    }
  }

  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print(pageContent[nvc!.currentIndex][pickerView.tag][pageContent[nvc!.currentIndex][pickerView.tag].count - 1])
    print(pageContent[nvc!.currentIndex][pickerView.tag][pickerView.selectedRowInComponent(component)])
  }
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    
    return self.pageContent[self.nvc!.currentIndex].count + 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return 1
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int)->String?
  {
    if section < self.pageContent[self.nvc!.currentIndex].count
    {
      let sectionHeader = self.pageContent[self.nvc!.currentIndex][section]
      
      return sectionHeader[sectionHeader.count - 1]

    }
    else
    {
      return ""
    }
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
  {
    return 60
  }
  
  

 //called for how many rows in a section
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    if indexPath.section == 0
    {
      let Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "PickerCell")
      let pickerView: UIPickerView = UIPickerView(frame: CGRectMake(self.tableView.frame.width/2 - 100, -20, 200, 100))
      pickerView.tag = indexPath.section
      pickerView.dataSource = self
      pickerView.delegate = self
      Cell.contentView.addSubview(pickerView)
      cellArray.append(Cell)
      return Cell
    }
    else if indexPath.section < self.pageContent[self.nvc!.currentIndex].count
    {
      let Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "PickerCell")
      let pickerView: UIPickerView = UIPickerView(frame: CGRectMake(self.tableView.frame.width/2 - 100, -20, 200, 100))
      pickerView.tag = indexPath.section
      pickerView.dataSource = self
      pickerView.delegate = self
      Cell.contentView.addSubview(pickerView)
      cellArray.append(Cell)

      return Cell
    }
    else
    {
      let Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ButtonCell")
      
      let doneButton = UIButton(frame: CGRectMake(self.tableView.frame.size.width / 2 - 50, 0, 100, 50))
      doneButton.addTarget(self, action: #selector(NeckExamView.buttonPressed(_:)), forControlEvents: .TouchUpInside)
      

      
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
  }
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.cellForRowAtIndexPath(indexPath)?.selected = false
    tableView.cellForRowAtIndexPath(indexPath)?.focusStyle = .Custom
  }

}

