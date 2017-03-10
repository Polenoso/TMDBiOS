//
//  FilmView.swift
//  theiostmdb
//
//  Created by davidjose gutierrez calderon  on 10/3/17.
//
//

import UIKit

class FilmView: UIView {
    
    var overviewTV: UILabel

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        overviewTV = UILabel()
        overviewTV.frame = frame;
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        overviewTV = UILabel()
        super.init(coder: aDecoder)
    }
    
    
}
