//
//  FilmViewCell.swift
//  theiostmdb
//
//  Created by aitor pagan  on 14/3/17.
//
//

import UIKit

class FilmViewCell: UITableViewCell {
    
    var overview: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.overview = UILabel.init(frame: CGRect(x:self.contentView.frame.origin.x,y:self.contentView.frame.origin.y,width:self.contentView.frame.size.width,height:self.contentView.frame.size.height))
        self.overview?.allowsDefaultTighteningForTruncation = true
        self.overview?.numberOfLines = .allZeros
        self.overview?.lineBreakMode = .byTruncatingTail
        self.overview?.frame = self.layer.frame
        self.contentView.addSubview(overview!)
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
