//
//  CognitiveConcentrationViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/24/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class CognitiveConcentrationViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let Questions: [String] = [
        "4-9-3",
        "3-8-1-4",
        "6-2-9-7-1",
        "7-1-8-4-6-2"
    ]
    let Frame = UIScreen.mainScreen().bounds
    var OrientationScore: Int? = nil
    var CollectionView: UICollectionView!
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let CorrectAnswerSC = UISegmentedControl(items: Ratings)
        
        // Set up frame for Segmented Control
        //CorrectAnswerSC.frame = CGRectMake(Frame.minX + 20, Frame.minY + 100, Frame.width - 40, 35)
        
        //self.view.addSubview(CorrectAnswerSC)
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: Frame.width, height: Frame.height/5)
        
        CollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.registerClass(TestCell.self, forCellWithReuseIdentifier: "TestCell")
        CollectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(CollectionView)
        
        DisplayTestInstructions("Select for incorrect or correct responses.")
        
        self.title = "Concentration"
        self.navigationItem.prompt = "Assessment for <Player.name>"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CognitiveConcentrationViewController.SaveOrientationScore))
    
        // let TestMenuTableView = UITableView()
        // TestMenuTableView.dataSource = self
        // TestMenuTableView.delegate = self
        // TestMenuTableView.backgroundColor = UIColor.whiteColor()
        // Above same as UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Questions.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCellWithReuseIdentifier("TestCell", forIndexPath: indexPath) as! TestCell
        Cell.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        Cell.QuestionLabel.text = Questions[indexPath.item]
        print(Questions[indexPath.item])
        
        return Cell
    }
    
    func SaveOrientationScore() {
        // Set the properties from the Scoreboard
    }
    
    func DisplayTestInstructions(Text: String) {
        let topOffset = self.navigationController!.navigationBar.bounds.height + UIApplication.sharedApplication().statusBarFrame.size.height
        let TopLabel = UILabel(frame: CGRect(x: 10, y: topOffset, width: Frame.size.width, height: 30))
        TopLabel.text = Text
        TopLabel.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(TopLabel)
    }
}