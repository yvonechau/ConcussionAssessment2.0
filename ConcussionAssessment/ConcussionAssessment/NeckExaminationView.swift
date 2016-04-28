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


class NeckExamViewController: TablePageViewController
{
  
}

class NeckExamView: TablePageView, UIPickerViewDataSource, UIPickerViewDelegate
{
  
  var textField: UITextField
  var pickerView: UIPickerView
  
  
  required init?(coder aDecoder: NSCoder)
  {
    <#code#>
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    self.pickerView.dataSource = self
    self.pickerView.delegate = self
    
  }
  
  // Data Source Methods
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
  {
    return self.LabelArray.count
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
  
  override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
  {
    let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
    
    header.textLabel?.font = UIFont(name: "Helvetica Neue", size: 20.0)
    
  }
  
  
//  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//  {
//    return LabelArray[self.pvc!.currentIndex].count
//  }
//  
//  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
//  {
//    
//    
//    
//    return Cell
//  }
//  
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    rowSel = indexPath.item
  }
}
