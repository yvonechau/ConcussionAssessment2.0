//
//  PlayerProfileViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 4/6/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class PlayerProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var Text: [String] = ["Number of Symptoms", "Severity", "Orientation", "Immediate memory", "Concentration", "Delayed recall", "SAC Total", "Maddocks", "Glasgow"]
    var collectionView: UICollectionView!
    var numberScoresDisplayed: Int!
    var name: String!
    var playerID: Int!
    let Frame = UIScreen.mainScreen().bounds
    
    let numberOfColumns = 3
    let innerSpacing: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberScoresDisplayed = 15 + 1
        self.title = name

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        let navigationBarHeight: CGFloat = navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.size.height
        let ProfileTopArea = Frame.origin.y + navigationBarHeight
        
        let PlayerName = UILabel(frame: CGRect(x: Frame.origin.x + 10, y: ProfileTopArea, width: Frame.width - 20, height: 60))
        //PlayerName.lineBreakMode = .ByWordWrapping
        //PlayerName.numberOfLines = 0
        PlayerName.text = self.name
        PlayerName.font = UIFont.systemFontOfSize(60, weight: UIFontWeightLight)
        PlayerName.textColor = UIColor.blackColor()
        PlayerName.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = innerSpacing * 2;
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(LabelCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        self.view.addSubview(collectionView)
    }
    
    init(name: String, playerID: Int) {
        super.init(nibName: nil, bundle: nil)
        self.name = name
        self.playerID = playerID
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberScoresDisplayed
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! LabelCell
        cell.setCellText("Text")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let squareDims = (collectionView.bounds.size.width - CGFloat(numberOfColumns + 1) * innerSpacing) / CGFloat(numberOfColumns)
        
        return CGSize(width: squareDims, height: squareDims)
    }
 
    private class LabelCell : UICollectionViewCell {
        var label : UILabel;
        
        override init(frame: CGRect) {
            label = UILabel(frame: frame);
            
            super.init(frame: frame)
            
            label.font = UIFont.systemFontOfSize(30, weight: UIFontWeightLight)
            label.frame = self.contentView.bounds
            self.backgroundColor = UIColor.whiteColor()
            self.contentView.addSubview(label)
        }
        
        func setCellText(cellText : String) {
            label.text = cellText
        }

        required init?(coder aDecoder: NSCoder) {
            // don't support encoding
            fatalError("init(coder:) has not been implemented")
        }
    }
}
