//
//  PlayerProfileViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 4/6/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class PlayerProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate {
    var catText: [String] = ["SAC Total", "Number of Symptoms", "Severity", "Orientation", "Immediate memory", "Concentration", "Delayed recall", "Maddocks Score", "Glasgow Score"]
    var collectionView: UICollectionView!
    var numberScoresDisplayed: Int!
    var name: String!
    var playerID: String!
    var scoreResults: [[String?]]
    var scoreTitles: [String]
    var scoresOfPlayer: [Score]
    var didGetScores: Bool = true
    var infoButton: UIButton
    let Frame = UIScreen.mainScreen().bounds
    
    var innerSpacing: CGFloat
    let numberOfColumns = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberScoresDisplayed = catText.count * numberOfColumns
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
        
        infoButton = UIButton(type: .InfoLight)
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
    
        infoButton = UIButton(type: .InfoLight)
        self.scoreResults = []
        self.scoreTitles = []
        self.name = name
        self.playerID = playerID
        self.scoresOfPlayer = database.scoresOfPlayer(self.playerID)
        print(scoresOfPlayer.count)
        
        if scoresOfPlayer.count <= 0 {
            didGetScores = false
        } else {
            print("Scores of player: \(scoresOfPlayer.count)")
            let (tempScoreTitles, tempScoreResults) = database.scoreStringArray(scoresOfPlayer[0].scoreID!)
            scoreResults.append(tempScoreResults)
            scoreTitles = tempScoreTitles
        }
        
        var scoreCount = 0
        /*while(scoreCount < scoresOfPlayer.count) {
            if (scoreCount > 3) {
                break;
            }
            let (tempScoreTitles, tempScoreResults) = database.scoreStringArray(scoresOfPlayer[scoreCount].scoreID!)
            scoreResults.append(tempScoreResults)
            scoreTitles = tempScoreTitles
            scoreCount += 1
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
        
        setFrameForScoreDisplay(cell, isTopRow: false)
        switch categoryNumber {
        case 0:
            cell.label.textColor = UIColor(rgb: 0xff5e3a)
            switch scoresOfPlayer.count - 1 {
            case 0:
                setFrameForScoreDisplay(cell, isTopRow: true)
                cell.setCellText(scoreResults[0][6]!, categoryLabelText: catText[0], testInfoText: "Baseline")
            case 1:
                setFrameForScoreDisplay(cell, isTopRow: true)
                cell.setCellText(scoreResults[1][6]!, categoryLabelText: catText[0], testInfoText: "Post-injury 1")
            case 2:
                setFrameForScoreDisplay(cell, isTopRow: true)
                cell.setCellText(scoreResults[2][6]!, categoryLabelText: catText[0], testInfoText: "Post-injury 2")
            default:
                cell.label.textColor = UIColor(rgb: 0xff3b30)
                cell.setCellText("--", categoryLabelText: "No tests/invalid test!")
            }
        case 1:
            cell.label.textColor = UIColor(rgb: 0x007aff)
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][0]!, categoryLabelText: catText[1])
            case 1:
                cell.setCellText(scoreResults[1][0]!, categoryLabelText: catText[1])
            case 2:
                cell.setCellText(scoreResults[2][0]!, categoryLabelText: catText[1])
            default:
                cell.label.textColor = UIColor(rgb: 0xff3b30)
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 2:
            cell.label.textColor = UIColor(rgb: 0x5856d6)
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][1]!, categoryLabelText: catText[2])
            case 1:
                cell.setCellText(scoreResults[1][1]!, categoryLabelText: catText[2])
            case 2:
                cell.setCellText(scoreResults[2][1]!, categoryLabelText: catText[2])
            default:
                cell.label.textColor = UIColor(rgb: 0xff3b30)
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 3:
            cell.label.textColor = UIColor(rgb: 0xff5e3a)
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][2]!, categoryLabelText: catText[3])
            case 1:
                cell.setCellText(scoreResults[1][2]!, categoryLabelText: catText[3])
            case 2:
                cell.setCellText(scoreResults[2][2]!, categoryLabelText: catText[3])
            default:
                cell.label.textColor = UIColor(rgb: 0xff3b30)
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 4:
            cell.label.textColor = UIColor(rgb: 0xff5e3a)
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][3]!, categoryLabelText: catText[4])
            case 1:
                cell.setCellText(scoreResults[1][3]!, categoryLabelText: catText[4])
            case 2:
                cell.setCellText(scoreResults[2][3]!, categoryLabelText: catText[4])
            default:
                cell.label.textColor = UIColor(rgb: 0xff3b30)
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 5:
            cell.label.textColor = UIColor(rgb: 0xff5e3a)
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][4]!, categoryLabelText: catText[5])
            case 1:
                cell.setCellText(scoreResults[1][4]!, categoryLabelText: catText[5])
            case 2:
                cell.setCellText(scoreResults[2][4]!, categoryLabelText: catText[5])
            default:
                cell.label.textColor = UIColor(rgb: 0xff3b30)
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        case 6:
            cell.label.textColor = UIColor(rgb: 0xff5e3a)
            switch scoresOfPlayer.count - 1 {
            case 0:
                cell.setCellText(scoreResults[0][5]!, categoryLabelText: catText[6])
            case 1:
                cell.setCellText(scoreResults[1][5]!, categoryLabelText: catText[6])
            case 2:
                cell.setCellText(scoreResults[2][5]!, categoryLabelText: catText[6])
            default:
                cell.label.textColor = UIColor(rgb: 0xff3b30)
                cell.setCellText("--", categoryLabelText: "N/A")
            }
        default:
            cell.label.textColor = UIColor(rgb: 0xff3b30)
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
        let numberOfScoresToDisplay: Int = 1
        return numberOfScoresToDisplay
    }
    
    func infoButtonPressed() {
        let cancelButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(self.doneWithInfo))
        let userInfoPopover = PopoverTableController(style: UITableViewStyle.Grouped, playerID: playerID)
        userInfoPopover.modalPresentationStyle = .Popover
        userInfoPopover.setToolbarItems([cancelButton], animated: true)
        
        let popOverController = userInfoPopover.popoverPresentationController
        popOverController?.permittedArrowDirections = .Up
        popOverController?.sourceView = self.infoButton
        popOverController?.sourceRect = CGRectMake(infoButton.frame.width, infoButton.frame.height, 0, 0)
        
        popOverController?.delegate = userInfoPopover
        self.presentViewController(userInfoPopover, animated: true, completion: nil)
    }
    
    func doneWithInfo(popover: PopoverTableController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func setFrameForScoreDisplay(Cell: LabelCell, isTopRow: Bool) {
        if isTopRow {
            Cell.label.frame = CGRect(x: Cell.contentView.frame.origin.x, y: Cell.contentView.frame.maxY/3, width: Cell.contentView.frame.width, height: Cell.contentView.frame.height/3)
            Cell.testInfoLabel.frame = CGRect(x: Cell.contentView.frame.maxX/6, y: Cell.contentView.frame.minY, width: Cell.contentView.frame.width*2/3, height: Cell.contentView.frame.height/3)
            Cell.categoryLabel.frame = CGRect(x: Cell.contentView.frame.maxX/6, y: 2*Cell.contentView.frame.maxY/3, width: Cell.contentView.frame.width*2/3, height: Cell.contentView.frame.height/3)
        } else {
            Cell.label.frame = CGRect(x: Cell.contentView.frame.origin.x, y: Cell.contentView.frame.origin.y, width: Cell.contentView.frame.width, height: 2*Cell.contentView.frame.height/3)
            switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Phone:
                Cell.categoryLabel.frame = CGRect(x: Cell.contentView.frame.maxX/6, y: Cell.contentView.frame.maxY/3, width: Cell.contentView.frame.width*2/3, height: 2*Cell.contentView.frame.height/3)
                Cell.testInfoLabel.frame = CGRect(x: Cell.contentView.frame.maxX/6, y: Cell.contentView.frame.minY, width: Cell.contentView.frame.width*2/3, height: Cell.contentView.frame.height/3)
            case .Pad:
                Cell.categoryLabel.frame = CGRect(x: Cell.contentView.frame.origin.x, y: Cell.contentView.frame.maxY/3, width: Cell.contentView.frame.width, height: 2*Cell.contentView.frame.height/3)
                Cell.testInfoLabel.frame = CGRect(x: Cell.contentView.frame.maxX/6, y: Cell.contentView.frame.minY, width: Cell.contentView.frame.width*2/3, height: Cell.contentView.frame.height/3)
            default:
                Cell.categoryLabel.frame = CGRect(x: Cell.contentView.frame.maxX/6, y: Cell.contentView.frame.maxY/3, width: Cell.contentView.frame.width*2/3, height: 2*Cell.contentView.frame.height/3)
                Cell.testInfoLabel.frame = CGRect(x: Cell.contentView.frame.maxX/6, y: Cell.contentView.frame.minY, width: Cell.contentView.frame.width*2/3, height: Cell.contentView.frame.height/3)
            }
        }
    }
   
    class PopoverTableController: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDelegate {
        let tableTitleArray: [[String]] = [["First", "Last"], ["Team", "ID", "Gender", "Birthday"]]
        let currentPlayerID: String
        var currentPlayer: Player
        var tableView: UITableView
        
        init(style: UITableViewStyle, playerID: String) {
            currentPlayerID = playerID
            currentPlayer = database.playerWithID(playerID)[0]
            tableView = UITableView(frame: CGRectZero, style: .Grouped)
            super.init(nibName: nil, bundle: nil)
        }
        
        override func viewDidLoad() {
            tableView.frame = self.view.frame
            tableView.delegate = self
            self.view.addSubview(tableView)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func preferredStatusBarStyle() -> UIStatusBarStyle {
            return UIStatusBarStyle.Default
        }
        
        func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
            return UIModalPresentationStyle.FullScreen
        }
        
        func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
            let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
            let doneButton = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(PopoverTableController.dismissPopover))
            navigationController.topViewController!.navigationItem.rightBarButtonItem = doneButton
            return navigationController
        }
        
        func dismissPopover() {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return tableTitleArray.count
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableTitleArray[section].count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let Cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
            Cell.textLabel?.text = tableTitleArray[indexPath.section][indexPath.item]
            switch indexPath.section {
            case 0:
                switch indexPath.item {
                case 0:
                    Cell.detailTextLabel?.text = currentPlayer.firstName
                case 1:
                    Cell.detailTextLabel?.text = currentPlayer.lastName
                default:
                    fatalError("Error with populating table")
                }
            case 1:
                switch indexPath.item {
                case 0:
                    Cell.detailTextLabel?.text = currentPlayer.teamName
                case 1:
                    if let id = currentPlayer.idNumber {
                        Cell.detailTextLabel?.text = id
                    } else {
                        Cell.detailTextLabel?.text = "No ID available"
                    }
                case 2:
                    Cell.detailTextLabel?.text = currentPlayer.gender
                case 3:
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM / dd / yyyy"
                    let birthdateString = dateFormatter.stringFromDate(currentPlayer.birthday!)
                    Cell.detailTextLabel?.text = birthdateString
                default:
                    fatalError("Error with populating table")
                }
            default:
                fatalError("Error with populating table")
            }
            return Cell
        }
    }
 
    private class LabelCell: UICollectionViewCell {
        var testInfoLabel: UILabel
        var label: UILabel
        var categoryLabel: UILabel
        
        override init(frame: CGRect) {
            label = UILabel(frame: frame)
            categoryLabel = UILabel(frame: frame)
            testInfoLabel = UILabel(frame: frame)
            
            super.init(frame: frame)
            
            // options for main score label
            label.font = UIFont.systemFontOfSize(CGFloat(60.0), weight: UIFontWeightUltraLight)
            label.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: self.contentView.frame.width, height: 2*self.contentView.frame.height/3)
            label.backgroundColor = UIColor(rgb: 0xfefefe)
            label.textColor = UIColor(rgb: 0xff3b30)
            label.textAlignment = .Center
            
            // options for score category labels
            switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Phone:
                categoryLabel.font = UIFont.systemFontOfSize(CGFloat(12.0))
                categoryLabel.numberOfLines = 0
                categoryLabel.frame = CGRect(x: self.contentView.frame.maxX/6, y: self.contentView.frame.maxY/3, width: self.contentView.frame.width*2/3, height: 2*self.contentView.frame.height/3)
                testInfoLabel.font = UIFont.systemFontOfSize(CGFloat(12.0))
                testInfoLabel.frame = CGRect(x: self.contentView.frame.maxX/6, y: self.contentView.frame.minY, width: self.contentView.frame.width*2/3, height: self.contentView.frame.height/3)
            case .Pad:
                categoryLabel.font = UIFont.systemFontOfSize(CGFloat(20.0))
                categoryLabel.numberOfLines = 1
                categoryLabel.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.maxY/3, width: self.contentView.frame.width, height: 2*self.contentView.frame.height/3)
                testInfoLabel.font = UIFont.systemFontOfSize(CGFloat(20.0))
                testInfoLabel.frame = CGRect(x: self.contentView.frame.maxX/6, y: self.contentView.frame.minY, width: self.contentView.frame.width*2/3, height: self.contentView.frame.height/3)
            default:
                categoryLabel.adjustsFontSizeToFitWidth = true
                categoryLabel.frame = CGRect(x: self.contentView.frame.maxX/6, y: self.contentView.frame.maxY/3, width: self.contentView.frame.width*2/3, height: 2*self.contentView.frame.height/3)
                testInfoLabel.adjustsFontSizeToFitWidth = true
                testInfoLabel.frame = CGRect(x: self.contentView.frame.maxX/6, y: self.contentView.frame.minY, width: self.contentView.frame.width*2/3, height: self.contentView.frame.height/3)
            }
            categoryLabel.textAlignment = .Center
            testInfoLabel.textAlignment = .Center
            
            // set bgcolor and add to contentView of cell
            self.backgroundColor = UIColor.whiteColor()
            self.contentView.addSubview(label)
            self.contentView.addSubview(categoryLabel)
            self.contentView.addSubview(testInfoLabel)
        }
        
        func setCellText(cellText: String, categoryLabelText: String, testInfoText: String) {
            label.text = cellText
            categoryLabel.text = categoryLabelText
            testInfoLabel.text = testInfoText
        }
        
        func setCellText(cellText: String, categoryLabelText: String) {
            label.text = cellText
            categoryLabel.text = categoryLabelText
            testInfoLabel.text = ""
        }

        required init?(coder aDecoder: NSCoder) {
            // don't support encoding
            fatalError("init(coder:) has not been implemented")
        }
    }
}
