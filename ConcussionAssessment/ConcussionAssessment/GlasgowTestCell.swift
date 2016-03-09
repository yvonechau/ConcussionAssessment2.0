//
//  GlasgowTestCell.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 3/9/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class GlasgowTestCell: UICollectionViewCell {
    var QuestionLabel: UILabel!
    var InfoLabel: UILabel!
    var RatingsSC: UISegmentedControl!
    var Ratings: [String]
    let OffsetX: CGFloat = 10
    
    override init(frame: CGRect) {
        QuestionLabel = UILabel(frame: CGRect(x: 10, y: 0, width: frame.size.width, height: 30))
        InfoLabel = UILabel(frame: CGRect(x: 10, y: 100, width: frame.size.width, height: 30))
        Ratings = ["1", "2", "3", "4", "5"]
        RatingsSC = UISegmentedControl(items: Ratings)
        RatingsSC.backgroundColor = UIColor.whiteColor()
        RatingsSC.layer.cornerRadius = 5.0
        RatingsSC.frame = CGRectMake(frame.origin.x + OffsetX, QuestionLabel.frame.height*2, frame.size.width - 2*OffsetX , 35)
        
        super.init(frame: frame)
        
        //QuestionLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        QuestionLabel.textAlignment = .Left
        InfoLabel.textAlignment = .Left
        contentView.addSubview(RatingsSC)
        contentView.addSubview(QuestionLabel)
        contentView.addSubview(InfoLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetCustomRatings(Ratings: [String]) {
        self.Ratings = Ratings
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
