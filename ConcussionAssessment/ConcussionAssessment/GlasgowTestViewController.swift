//
//  CognitiveOrientationViewController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 2/24/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class GlasgowTestViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let Questions: [String] = [
        "Best eye response?",
        "Best verbal response?",
        "Best motor response?",
    ]
    let Infos: [String] = [
        "No eye opening = 1, Eyes opening spontaneously = 5",
        "No verbal response = 1, Oriented = 5",
        "No motor response = 1, Obeys commands = 5",
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: Frame.width, height: Frame.height/5)
        
        CollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.registerClass(GlasgowTestCell.self, forCellWithReuseIdentifier: "GlasgowTestCell")
        CollectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(CollectionView)
        
        DisplayTestInstructions("Select on scale, 1 = Poor, 5 = Good.")
        
        self.title = "Glasgow Coma Scale"
        self.navigationItem.prompt = "Assessment for <Player.name>"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "SaveOrientationScore")
        
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
        let Cell = collectionView.dequeueReusableCellWithReuseIdentifier("GlasgowTestCell", forIndexPath: indexPath) as! GlasgowTestCell
        Cell.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        Cell.QuestionLabel.text = Questions[indexPath.item]
        Cell.InfoLabel.text = Infos[indexPath.item]
        print(Questions[indexPath.item])
        
        return Cell
    }
    
    func SaveOrientationScore() {
        // Set the properties from the Scoreboard
    }
    
    func DisplayTestInstructions(Text: String) {
        let topOffset = self.navigationController!.navigationBar.bounds.height + UIApplication.sharedApplication().statusBarFrame.size.height
        let TopLabel = UILabel(frame: CGRect(x: 10, y:topOffset, width: Frame.size.width, height: 30))
        TopLabel.text = Text
        TopLabel.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(TopLabel)
    }
}
