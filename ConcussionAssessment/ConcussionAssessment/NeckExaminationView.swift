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
  let pageContent : [[[String]]]

  
  init(pageTitles : Array<String>, labelArray: Array<Array<String>>, testName : String, instructionPage : TablePageView?, instructions: String, next: TablePageViewController?, original: UIViewController?, numTrials: [Int]?, singlePage: BooleanType, pageContent: [[[String]]])
  {
    self.pageContent = pageContent
    super.init(pageTitles: pageTitles, labelArray: labelArray, testName: testName, instructionPage: instructionPage, instructions: instructions, next: next, original: original, numTrials: numTrials, singlePage: singlePage)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class NeckExamView: TablePageView, UIPickerViewDataSource, UIPickerViewDelegate
{
  
  
  weak var nvc : NeckExamViewController?
  let pageContent : [[[String]]]
  
  
  var textField: UITextField
  var pickerView: UIPickerView
  
  init(nvc : NeckExamViewController)
  {
    
    self.nvc = nvc
    self.pageContent = nvc.pageContent
    self.textField = UITextField()
    self.pickerView = UIPickerView()
    
    super.init()
    super.setPVC(self.pvc)
    self.pickerView.dataSource = self
    self.pickerView.delegate = self
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    
  }
  
  // Data Source Methods
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
  {
    return self.pageContent[self.pvc!.currentIndex].count
  }
  
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cell = UITableViewCell()
    
    
    cell.addSubview(self.pickerView)
    
    return cell
  }
  
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    rowSel = indexPath.item
  }
}
