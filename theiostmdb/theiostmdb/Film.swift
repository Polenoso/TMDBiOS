//
//  Film.swift
//  theiostmdb
//
//  Created by davidjose gutierrez calderon  on 10/3/17.
//
//

import Foundation

struct Film {
    let poster_path : String
    let overview : String
    let release_date : String
    let title : String
    
    // MARK: - Initializers
    init(dictionary: [String: AnyObject]) {
        self.poster_path = dictionary["poster_path"] as! String
        self.overview = dictionary["overview"] as! String
        self.release_date = dictionary["release_date"] as! String
        self.title = dictionary["title"] as! String
    }
}
