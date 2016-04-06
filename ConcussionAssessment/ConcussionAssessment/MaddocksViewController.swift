//
//  MaddocksViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

//Things to fix:
//- Way to go to next test
//- Tally Scores out of 5 after going to next test
//- A checker to see if all answers have been filled out if proceeding to next test
//- Fix Dimmensions to fit all ios devices
//- UI Design


import UIKit

class MaddocksViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
  let questionArray = [
      "At what venue are we today?",
      "Which half is it now?",
      "Who scored last in this match?",
      "What did you play last week?",
      "Did your team win the last game?"]
    
  let Frame = UIScreen.mainScreen().bounds
  var OrientationScore: Int? = nil
  var CollectionView: UICollectionView!
  
  override func loadView()
  {
    super.loadView()
    self.view.backgroundColor = UIColor.whiteColor()
  }
  
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.title = "Maddocks Test"
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10)
    layout.itemSize = CGSize(width: Frame.width, height: Frame.height/6)
    
    CollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    CollectionView.dataSource = self
    CollectionView.delegate = self
    CollectionView.registerClass(TestCell.self, forCellWithReuseIdentifier: "TestCell")
    CollectionView.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(CollectionView)
    
    DisplayTestInstructions("Select for incorrect or correct responses.")
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MaddocksViewController.SaveMaddocksScore))
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return questionArray.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let Cell = collectionView.dequeueReusableCellWithReuseIdentifier("TestCell", forIndexPath: indexPath) as! TestCell
    Cell.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
    Cell.QuestionLabel.text = questionArray[indexPath.item]
    
    return Cell
  }
  
  func SaveMaddocksScore() {
    print("SaveMaddocksScore Button Pressed")
  }
  
  func DisplayTestInstructions(Text: String) {
    let topOffset = self.navigationController!.navigationBar.bounds.height + UIApplication.sharedApplication().statusBarFrame.size.height
    let TopLabel = UILabel(frame: CGRect(x: 10, y:topOffset, width: Frame.size.width, height: 30))
    TopLabel.text = Text
    TopLabel.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(TopLabel)
  }
  

  
  
}

