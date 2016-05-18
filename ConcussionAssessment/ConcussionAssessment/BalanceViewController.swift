//
//  BalanceViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {
  let pageTitle = ["Double Leg Stance", "Single Leg Stance", "Tandem Leg Stance"]
  let testName = "Balance Test"
  let instructions = "instructions"
  
  
  var original : UIViewController?
  
  init(originalPage: UIViewController)
  {
    self.original = originalPage
    
    super.init(nibName:nil, bundle:nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
}
