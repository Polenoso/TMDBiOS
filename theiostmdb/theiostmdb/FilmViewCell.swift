//
//  FilmViewCell.swift
//  theiostmdb
//
//  Created by aitor pagan  on 14/3/17.
//
//

import UIKit

class FilmViewCell: UITableViewCell {
    
    static let photoWidth: CGFloat = 150
    static let photoHeight: CGFloat = 200
    static let titleSize: CGFloat = 16.0
    static let overviewSize: CGFloat = 8.0
    static let releaseYear: CGFloat = 8.0
    
    @IBOutlet var overview: UILabel?
    @IBOutlet var photo: UIImageView?
    var stackView: UIStackView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Init Subviews frames
        self.photo = UIImageView.init(frame: CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: FilmViewCell.photoWidth, height: FilmViewCell.photoHeight))
        self.overview = UILabel.init(frame: CGRect(x:FilmViewCell.photoWidth,y:self.contentView.frame.origin.y,width:150.0,height:0.0))
        
        //Edit Subviews
        //overview
        self.overview?.allowsDefaultTighteningForTruncation = true
        self.overview?.numberOfLines = 0
        self.overview?.lineBreakMode = .byTruncatingTail
        self.overview?.frame = self.layer.frame
        //photo
        self.photo?.backgroundColor = UIColor.blue
        self.photo?.layer.cornerRadius = 15
        self.photo?.clipsToBounds = true
        self.stackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: self.contentView.frame.size.width, height: FilmViewCell.heightForCell(with: "")))
        stackView?.addArrangedSubview(photo!)
        stackView?.addArrangedSubview(overview!)
        stackView?.axis = .horizontal
        stackView?.distribution = .fillEqually
        stackView?.alignment = .top
        stackView?.spacing = 20.0
        stackView?.translatesAutoresizingMaskIntoConstraints = false
        
        //AddSubviews
        self.contentView.addSubview(stackView!)
        
        //Add Constraints
        let width = [NSLayoutConstraint(item: stackView!, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation(rawValue: 0)!, toItem: self.contentView, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)]
        let height = [NSLayoutConstraint(item: stackView!, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation(rawValue: 0)!, toItem: self.contentView, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0)]
        let top = [NSLayoutConstraint(item: stackView!, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)]
        let lead = [NSLayoutConstraint(item: stackView!, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)]
        self.contentView.addConstraints(width)
        self.contentView.addConstraints(height)
        self.contentView.addConstraints(top)
        self.contentView.addConstraints(lead)
        self.photo?.addConstraints([NSLayoutConstraint(item: photo!, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: FilmViewCell.photoWidth)])
        self.photo?.addConstraints([NSLayoutConstraint(item: photo!, attribute: NSLayoutAttribute.height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: FilmViewCell.photoHeight)])
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
    
    public static func heightForCell(with overview: String) -> CGFloat{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 0))
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.text = overview
        let size = label.sizeThatFits(CGSize(width: 150, height: CGFloat(overview.lengthOfBytes(using: .utf8))))
        return max(FilmViewCell.photoHeight, size.height)
    }

}
