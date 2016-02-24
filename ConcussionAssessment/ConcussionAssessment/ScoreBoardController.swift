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
    let scoreTitle = ["Number of Symptoms", "Symptom Severity", "Orientation", "Immediate Memory", "Concentration", "Delayed Recall", "SAC Total"]
    let scoreResults = ["Untested", "Untested", "Untested", "Untested", "Untested", "Untested", "N/A"]
    var y_pos: CGFloat = 0;
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        for index in 0...6
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
            score.text = scoreResults[index]
            self.view.addSubview(score)
            
            y_pos = y_pos + 30
        }
        
        
    }
}