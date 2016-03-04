//
//  ScoreBoardController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 2/24/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import UIKit

class ScoreBoardController : UIViewController
{
    let scoreTitle = ["Number of Symptoms", "Symptom Severity", "Orientation", "Immediate Memory", "Concentration", "Delayed Recall", "SAC Total", "Maddocks Score", "Glasgow Score"]
    var scoreResults: [String?] = []
    var y_pos: CGFloat = 0;
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        scoreResults[0] = (currentScore?.numSymptoms)?.stringValue
        scoreResults[1] = (currentScore?.severity)?.stringValue
        scoreResults[2] = (currentScore?.orientation)?.stringValue
        scoreResults[3] = (currentScore?.immediateMemory)?.stringValue
        scoreResults[4] = (currentScore?.concentration)?.stringValue
        scoreResults[5] = (currentScore?.delayedRecall)?.stringValue
        
        scoreResults[7] = (currentScore?.maddocks)?.stringValue
        scoreResults[8] = (currentScore?.glasgow)?.stringValue
        
    
        var total: Int = 0
        for i in 0...6
        {
            if let str = scoreResults[i]{
                total += Int(str)!
            }
        }
        
        for index in 0...8
        {
            let title = UILabel(frame: CGRect(x: 20, y: y_pos, width: view.frame.width, height: 200))
            title.textColor = UIColor.blackColor()
            //label.center = CGPointMake(160, 284)
            title.textAlignment = .Left
            title.text = scoreTitle[index]
            self.view.addSubview(title)
            
            let score = UILabel(frame: CGRect(x: -20, y: y_pos, width: view.frame.width, height: 200))
            score.textColor = UIColor.blackColor()
            //label.center = CGPointMake(160, 284)
            score.textAlignment = .Right
            if let str = scoreResults[index] {
                score.text = str
            } else {
                score.text = "Untested"
            }
            self.view.addSubview(score)
            
            y_pos = y_pos + 30
        }
        
        
    }
}