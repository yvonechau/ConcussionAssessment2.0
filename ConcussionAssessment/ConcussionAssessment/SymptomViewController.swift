//
//  SymptomViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit


class SymptomViewController: UIViewController, UIPageViewControllerDataSource{
  
  var pageViewController: UIPageViewController?
  
  var pageTitles : Array<String> = ["Headache", "Pressure in Head", "Neck Pain", "Nausea or Vomiting", "Dizziness", "Blurred Vision", "Balance Problems", "Sensitivity to Light", "Sensitivity to Noise", "Feeling Slowed Down", "Feeling like 'in a fog'", "Don't Feel Right", "Difficulty Concentrating", "Difficulty Remembering", "Fatigue or Low Energy", "Confusion", "Drowsiness", "Trouble Falling Asleep", "More Emotional", "Irrability", "Sadness", "Nervous or Anxious"]
  
  var currentIndex : Int = 0
  var limitIndex: Int = 0
  var segCtrl: UISegmentedControl?
  
  var currScore: NSNumber?
  override func viewDidLoad()
  {
    super.viewDidLoad()
    pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    pageViewController!.dataSource = self
    
    let startingViewController: SymptomView = viewControllerAtIndex(0)!
    segCtrl = startingViewController.segCtrl
    let viewControllers = [startingViewController]
    pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
    pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    
    addChildViewController(pageViewController!)
    view.addSubview(pageViewController!.view)
    pageViewController!.didMoveToParentViewController(self)
    
  }
  
  override func didReceiveMemoryWarning() {
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
    currentScore!.numSymptoms = currentScore!.numSymptoms!.integerValue - currScore!.integerValue //SAVE AS AN NSNUMBER

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
    limitIndex = index - 1
    currScore = segCtrl?.selectedSegmentIndex
    currentScore!.numSymptoms = currentScore!.numSymptoms!.integerValue + currScore!.integerValue //SAVE AS AN NSNUMBER
    if(index == self.pageTitles.count)
    {
      return nil
    }
    
    // SAVE VALUE HERE
    //currentScore!.numSymptoms = //SAVE AS AN NSNUMBER 
    
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

class SymptomView: UIViewController
{
  var pageIndex : Int = 0
  var titleText : String = ""
  var segCtrl: UISegmentedControl?
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    
    view.backgroundColor = UIColor.lightGrayColor()
    let title = UILabel(frame: CGRectMake(0,60, view.frame.width, 50))
    title.textColor = UIColor.lightGrayColor()
    title.text = "        Symptom Evaluation"
    title.font = title.font.fontWithSize(17)
    title.textAlignment = .Left
    title.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
    view.addSubview(title)
    
    let label = UILabel(frame: CGRectMake(0,55, view.frame.width, 200))
    label.textColor = UIColor.whiteColor()
    label.font = UIFont.boldSystemFontOfSize(20.0)
    label.text = titleText
    label.textAlignment = .Center
    view.addSubview(label)
    
    
    segCtrl =
    {
      let numbers = ["0", "1", "2", "3", "4", "5", "6"]
      let segButton = UISegmentedControl(items: numbers)
      segButton.frame = CGRectMake(10, 230, view.frame.width - 20, 44)
      segButton.selectedSegmentIndex = 0
      segButton.backgroundColor = UIColor.whiteColor()
      segButton.layer.cornerRadius = 5.0
      segButton.clipsToBounds = true
      segButton.addTarget(self, action: "segmentedControlValueChanged:", forControlEvents:.TouchUpInside)
      
      return segButton
    }()
    
    let none = UILabel(frame: CGRectMake(20,195,44,44))
    none.textColor = UIColor.whiteColor()
    none.backgroundColor = UIColor.clearColor()
    none.text = "none"
    none.textAlignment = .Center
    view.addSubview(none)
    
    
    let mild = UILabel(frame: CGRectMake(105,195,44,44))
    mild.textColor = UIColor.whiteColor()
    mild.backgroundColor = UIColor.clearColor()
    mild.text = "mild"
    mild.textAlignment = .Center
    view.addSubview(mild)
    
    
    let moderate = UILabel(frame: CGRectMake(190,195,80,44))
    moderate.backgroundColor = UIColor.clearColor()
    moderate.textColor = UIColor.whiteColor()
    moderate.text = "moderate"
    moderate.textAlignment = .Center
    view.addSubview(moderate)
    
    let severe = UILabel(frame: CGRectMake(310,195,80,44))
    severe.backgroundColor = UIColor.clearColor()
    severe.textColor = UIColor.whiteColor()
    severe.text = "severe"
    severe.textAlignment = .Center
    view.addSubview(severe)
    
    self.view.addSubview(segCtrl!)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
 }