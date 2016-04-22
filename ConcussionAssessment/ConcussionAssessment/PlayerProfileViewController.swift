//
//  PlayerProfileViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 4/6/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class PlayerProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var collectionView: UICollectionView!
    var numberScoresDisplayed: Int!
    let Frame = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberScoresDisplayed = 9

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        let navigationBarHeight: CGFloat = navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.size.height
        let ProfileTopArea = Frame.origin.y + navigationBarHeight
        
        let PlayerName = UILabel(frame: CGRect(x: Frame.origin.x + 10, y: ProfileTopArea, width: Frame.width - 20, height: 60))
        //PlayerName.lineBreakMode = .ByWordWrapping
        //PlayerName.numberOfLines = 0
        PlayerName.text = "John Smith"
        PlayerName.font = UIFont(name: "HelveticaNeue", size: 30)
        PlayerName.textColor = UIColor.blackColor()
        PlayerName.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: PlayerName.frame.height + 10, left: 10, bottom: 10, right: 10)
        //layout.itemSize = CGSize(width: Frame.width / 3, height: Frame.width / 3)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        self.view.addSubview(collectionView)
        self.view.addSubview(PlayerName)
    }
    
    init(name: String, playerID: 
    
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
    
}
