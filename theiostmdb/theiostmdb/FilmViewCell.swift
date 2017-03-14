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
        self.overview = UILabel.init(frame: CGRect(x:self.frame.origin.x,y:self.frame.origin.y,width:self.frame.size.width,height:self.frame.size.height))
        self.addSubview(overview!)
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
