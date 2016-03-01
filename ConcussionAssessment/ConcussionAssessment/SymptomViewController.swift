//
//  SymptomViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

import UIKit

class SymptomViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
  let customCellIdentifier = "customCellIdentfier"
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    collectionView?.backgroundColor = UIColor.whiteColor()
    
    collectionView?.registerClass(CustomCell.self, forCellWithReuseIdentifier: customCellIdentifier)
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)-> UICollectionViewCell
  {
    let customCell = collectionView.dequeueReusableCellWithReuseIdentifier(customCellIdentifier, forIndexPath: indexPath) as! CustomCell
    
    customCell.nameLabel.text = names[indexPath.item]
    return customCell//?
  }
  
  let names = ["Headache", "Pressure in Head", "Neck Pain", "Nausea or Vomiting", "Dizziness", "Blurred Vision", "Balance Problems", "Sensitivity to Light", "Sensitivity to Noise", "Feeling Slowed Down", "Feeling like 'in a fog'", "Don't Feel Right", "Difficulty Concentrating", "Difficulty Remembering", "Fatigue or Low Energy", "Confusion", "Drowsiness", "Trouble Falling Asleep", "More Emotional", "Irrability", "Sadness", "Nervous or Anxious"]
  override func collectionView(collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int
  {
    return 22
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
  {
    return CGSizeMake(view.frame.width, 200)
  }
}

class CustomCell: UICollectionViewCell
{
  override init(frame: CGRect) //called on dequeue of cells
  {
    super.init(frame: frame)
    setupViews()
  }
  
  let nameLabel: UILabel =
  {
    let label = UILabel()
    label.text = "Custom Text"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  let segCtrl: UISegmentedControl  =
  {
    let numbers = ["0", "1", "2", "3", "4", "5", "6"]
    let segButton = UISegmentedControl(items: numbers)
    segButton.frame = CGRectMake(100, 200, 200, 30)
    segButton.selectedSegmentIndex = 0
    segButton.translatesAutoresizingMaskIntoConstraints = false
    segButton.backgroundColor = UIColor.whiteColor()
    segButton.layer.cornerRadius = 4.0
    segButton.clipsToBounds = true
    
    return segButton
  }()
  
  func setupViews()
  {
    backgroundColor = UIColor.grayColor()
    addSubview(nameLabel)
    addSubview(segCtrl)
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
    
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":segCtrl]))
    //views is the dictionary, H width span the pipe of v0 set by the dictionary H for horizontal
    
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]-5-[v1]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel, "v1": segCtrl]))
    
    //    segButton.insertSegmentWithTitle("none", atIndex: 0, animated = true)
    //    segButton.insertSegmentWithTitle("mild", atIndices: 1, numberOfSegments: 2, animated:true)
    //    segButton.insertSegmentWithTitle("moderate", atIndices: 3, numberOfSegments: 2, animated: true)
    //    segButton.insertSegmentWithTitle("mild", atIndices: 5, numberOfSegments: 2, animated: true)
    
    
  }
  
  
  required init?(coder aDecoder: NSCoder)
  {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
