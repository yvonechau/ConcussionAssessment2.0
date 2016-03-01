//
//  TestCell.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 3/1/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell {
    var QuestionLabel: UILabel!
    var RatingsSC: UISegmentedControl!
    var Ratings: [String]
    let OffsetX: CGFloat = 10
    
    override init(frame: CGRect) {
        QuestionLabel = UILabel(frame: CGRect(x: 10, y: 0, width: frame.size.width, height: 30))
        Ratings = ["0", "1"]
        RatingsSC = UISegmentedControl(items: Ratings)
        RatingsSC.backgroundColor = UIColor.whiteColor()
        RatingsSC.layer.cornerRadius = 5.0
        RatingsSC.frame = CGRectMake(frame.origin.x + OffsetX, QuestionLabel.frame.height, frame.size.width - 2*OffsetX , 35)
        
        super.init(frame: frame)
        
        //QuestionLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        QuestionLabel.textAlignment = .Left
        contentView.addSubview(RatingsSC)
        contentView.addSubview(QuestionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetCustomRatings(Ratings: [String]) {
        self.Ratings = Ratings
    }
}
