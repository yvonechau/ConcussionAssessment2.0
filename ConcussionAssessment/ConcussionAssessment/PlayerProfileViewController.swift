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
        PlayerName.font = UIFont.systemFontOfSize(30, weight: UIFontWeightLight)
        PlayerName.textColor = UIColor.blackColor()
        PlayerName.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        
        let layout: ProfileCollectionViewLayout = ProfileCollectionViewLayout()
        //layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        //layout.itemSize = CGSize(width: Frame.width / 3, height: Frame.width / 3)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        self.view.addSubview(collectionView)
        //self.view.addSubview(PlayerName)
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let numberOfCols: CGFloat = 3
        let collectionViewCellSize: CGFloat = (collectionView.frame.width - ((numberOfCols + 1) * 7.5)) / numberOfCols
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width - 10, height: collectionViewCellSize)
        } else {
            return CGSize(width: collectionViewCellSize, height: collectionViewCellSize)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let cellWidthPadding: CGFloat = 5.0
        let cellHeightPadding: CGFloat = 5.0
        return UIEdgeInsets(top: cellHeightPadding,left: cellWidthPadding,
                            bottom: cellHeightPadding,right: cellWidthPadding)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacing section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineitemSpacing section: Int) -> CGFloat {
        return 5.0
    }
    
}
