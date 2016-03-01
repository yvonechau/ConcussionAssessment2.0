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
  override func viewDidLoad()
  {
    super.viewDidLoad()
    pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    pageViewController!.dataSource = self
    
    let startingViewController: SymptomView = viewControllerAtIndex(0)!
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

    if(index == self.pageTitles.count)
    {
      return nil
    }
    
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
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    
    view.backgroundColor = UIColor.lightGrayColor()
    let title = UILabel(frame: CGRectMake(0,60, view.frame.width, 50))
    title.textColor = UIColor.lightGrayColor()
    title.text = "        Symptom Evaluation"
    title.font = title.font.fontWithSize(15)
    title.textAlignment = .Left
    title.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
    //    title.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(title)
    
    let label = UILabel(frame: CGRectMake(0,55, view.frame.width, 200))
    label.textColor = UIColor.whiteColor()
    label.text = titleText
    label.textAlignment = .Center
    view.addSubview(label)
    
    
    
//    let button = UIButton(type: UIButtonType.System)
//    button.frame = CGRectMake(20, view.frame.height - 110, view.frame.width - 40, 50)
//    button.setTitle(titleText, forState: UIControlState.Normal)
//    button.addTarget(self, action: "Action", forControlEvents: UIControlEvents.TouchUpInside)
//    self.view.addSubview(button)
    
    let segCtrl: UISegmentedControl  =
    {
      let numbers = ["0", "1", "2", "3", "4", "5", "6"]
      let segButton = UISegmentedControl(items: numbers)
      segButton.frame = CGRectMake(100, 200, 195, 30)
      segButton.selectedSegmentIndex = 0
      segButton.translatesAutoresizingMaskIntoConstraints = false
      segButton.backgroundColor = UIColor.whiteColor()
      segButton.layer.cornerRadius = 5.0
      segButton.clipsToBounds = true
      
      return segButton
    }()
    self.view.addSubview(segCtrl)
    
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":segCtrl]))
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[v0]-400-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":segCtrl]))


  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
 }