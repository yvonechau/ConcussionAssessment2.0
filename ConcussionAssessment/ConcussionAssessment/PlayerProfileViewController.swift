//
//  PlayerProfileViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 4/6/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class PlayerProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var catText: [String] = ["SAC Total", "Number of Symptoms", "Severity", "Orientation", "Immediate memory", "Concentration", "Delayed recall", "Delayed Recall"]
    var collectionView: UICollectionView!
    var numberScoresDisplayed: Int!
    var name: String!
    var playerID: String!
    var scoreResults: [[String?]]
    var scoreTitles: [String]
    var scoresOfPlayer: [Score]
    var didGetScores: Bool = true
    let Frame = UIScreen.mainScreen().bounds
    
    var innerSpacing: CGFloat
    let numberOfColumns = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberScoresDisplayed = 21
        self.title = name

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        let navigationBarHeight: CGFloat = navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.size.height
        let ProfileTopArea = Frame.origin.y + navigationBarHeight
        
        /*let PlayerName = UILabel(frame: CGRect(x: Frame.origin.x + 10, y: ProfileTopArea, width: Frame.width - 20, height: 60))
        //PlayerName.lineBreakMode = .ByWordWrapping
        //PlayerName.numberOfLines = 0
        PlayerName.text = self.name
        PlayerName.font = UIFont.systemFontOfSize(60, weight: UIFontWeightLight)
        PlayerName.textColor = UIColor.darkTextColor()
        PlayerName.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1.0)*/
        
        let numberScores = getScoresForDisplay()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = innerSpacing * 2;
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(LabelCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        let infoButton: UIButton = UIButton(type: .InfoLight)
        infoButton.addTarget(self, action: #selector(self.infoButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
        self.view.addSubview(collectionView)
    }
    
    init(name: String, playerID: String) {
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Pad:
            innerSpacing = 4
        default:
            innerSpacing = 2
        }
    
        self.scoreResults = []
        self.scoreTitles = []
        self.name = name
        self.playerID = playerID
        self.scoresOfPlayer = database.scoresOfPlayer(self.playerID)
        print(scoresOfPlayer.count)
        
        if scoresOfPlayer.count <= 0 {
            didGetScores = false
        } else {
            let (tempScoreTitles, tempScoreResults) = database.scoreStringArray(scoresOfPlayer[0].scoreID!)
            scoreResults.append(tempScoreResults)
            scoreTitles = tempScoreTitles
        }
        
        /*for x in 0..<3 {
            (scoreTitles, scoreResults[x]) = database.scoreStringArray(scoresOfPlayer[x].scoreID!)
        }*/
        
        
        super.init(nibName: nil, bundle: nil)
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
        
        let categoryNumber = indexPath.item / numberOfColumns
        
        switch categoryNumber {
        case 0:
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][6]!, categoryLabelText: catText[0])
            case 1:
                cell.setCellText(scoreResults[1][6]!, categoryLabelText: catText[0])
            case 2:
                cell.setCellText(scoreResults[2][6]!, categoryLabelText: catText[0])
            default:
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 1:
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][0]!, categoryLabelText: catText[1])
            case 1:
                cell.setCellText(scoreResults[1][0]!, categoryLabelText: catText[1])
            case 2:
                cell.setCellText(scoreResults[2][0]!, categoryLabelText: catText[1])
            default:
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 2:
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][6]!, categoryLabelText: catText[0])
            case 1:
                cell.setCellText(scoreResults[1][6]!, categoryLabelText: catText[0])
            case 2:
                cell.setCellText(scoreResults[2][6]!, categoryLabelText: catText[0])
            default:
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 3:
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][1]!, categoryLabelText: catText[2])
            case 1:
                cell.setCellText(scoreResults[1][1]!, categoryLabelText: catText[2])
            case 2:
                cell.setCellText(scoreResults[2][1]!, categoryLabelText: catText[2])
            default:
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 4:
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][2]!, categoryLabelText: catText[3])
            case 1:
                cell.setCellText(scoreResults[1][2]!, categoryLabelText: catText[3])
            case 2:
                cell.setCellText(scoreResults[2][2]!, categoryLabelText: catText[3])
            default:
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 5:
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][4]!, categoryLabelText: catText[5])
            case 1:
                cell.setCellText(scoreResults[1][4]!, categoryLabelText: catText[5])
            case 2:
                cell.setCellText(scoreResults[2][4]!, categoryLabelText: catText[5])
            default:
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 6:
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][4]!, categoryLabelText: catText[5])
            case 1:
                cell.setCellText(scoreResults[1][4]!, categoryLabelText: catText[5])
            case 2:
                cell.setCellText(scoreResults[2][4]!, categoryLabelText: catText[5])
            default:
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 7:
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][5]!, categoryLabelText: catText[6])
            case 1:
                cell.setCellText(scoreResults[1][5]!, categoryLabelText: catText[6])
            case 2:
                cell.setCellText(scoreResults[2][5]!, categoryLabelText: catText[6])
            default:
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        default:
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText("invalid", categoryLabelText: "N/A")
            case 1:
                cell.setCellText("invalid", categoryLabelText: "N/A")
            case 2:
                cell.setCellText("invalid", categoryLabelText: "N/A")
            default:
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var squareDims: CGFloat
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Pad:
            squareDims = ((collectionView.bounds.size.width - CGFloat(numberOfColumns + 1) * innerSpacing) - 32) / CGFloat(numberOfColumns)
        default:
            squareDims = ((collectionView.bounds.size.width - CGFloat(numberOfColumns + 1) * innerSpacing) - 8) / CGFloat(numberOfColumns)
        }
        
        //let fullWidth = collectionView.bounds.size.width - 12.0
        //if indexPath.item == 0 {
        //    return CGSize(width: fullWidth, height: squareDims)
        //} else {
            return CGSize(width: squareDims, height: squareDims)
        //}
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var cellWidthPadding, cellHeightPadding: CGFloat
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            cellWidthPadding = 4.0
            cellHeightPadding = 4.0
        case .Pad:
            cellWidthPadding = 16.0
            cellHeightPadding = 16.0
        default:
            cellWidthPadding = 4.0
            cellHeightPadding = 4.0
        }
        return UIEdgeInsets(top: cellHeightPadding,left: cellWidthPadding, bottom: cellHeightPadding,right: cellWidthPadding)
    }
    
    func getScoresForDisplay() -> Int {
        var numberOfScoresToDisplay: Int = 1
        
        
        
        return numberOfScoresToDisplay
    }
    
    func infoButtonPressed() {
        
    }
 
    private class LabelCell : UICollectionViewCell {
        var testInfoLabel: UILabel
        var label: UILabel
        var categoryLabel: UILabel
        
        override init(frame: CGRect) {
            label = UILabel(frame: frame)
            categoryLabel = UILabel(frame: frame)
            testInfoLabel = UILabel(frame: frame)
            
            super.init(frame: frame)
            
            // options for main score label
            label.font = UIFont.systemFontOfSize(CGFloat(60.0), weight: UIFontWeightLight)
            label.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: self.contentView.frame.width, height: 2*self.contentView.frame.height/3)
            label.backgroundColor = UIColor(rgb: 0x1ad6fd)
            label.textAlignment = .Center
            
            // options for score category labels
            switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Phone:
                categoryLabel.font = UIFont.systemFontOfSize(CGFloat(12.0))
                categoryLabel.numberOfLines = 0
                categoryLabel.frame = CGRect(x: self.contentView.frame.maxX/6, y: self.contentView.frame.maxY/3, width: self.contentView.frame.width*2/3, height: 2*self.contentView.frame.height/3)
            case .Pad:
                categoryLabel.font = UIFont.systemFontOfSize(CGFloat(20.0))
                categoryLabel.numberOfLines = 1
                categoryLabel.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.maxY/3, width: self.contentView.frame.width, height: 2*self.contentView.frame.height/3)
            default:
                categoryLabel.adjustsFontSizeToFitWidth = true
                categoryLabel.frame = CGRect(x: self.contentView.frame.maxX/6, y: self.contentView.frame.maxY/3, width: self.contentView.frame.width*2/3, height: 2*self.contentView.frame.height/3)
            }
            categoryLabel.textAlignment = .Center
            
            // set bgcolor and add to contentView of cell
            self.backgroundColor = UIColor.whiteColor()
            self.contentView.addSubview(label)
            self.contentView.addSubview(categoryLabel)
        }
        
        func setCellText(cellText: String, categoryLabelText: String) {
            label.text = cellText
            categoryLabel.text = categoryLabelText
        }

        required init?(coder aDecoder: NSCoder) {
            // don't support encoding
            fatalError("init(coder:) has not been implemented")
        }
    }
}
