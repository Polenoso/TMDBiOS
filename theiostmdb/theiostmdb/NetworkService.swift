//
//  NetworkService.swift
//  theiostmdb
//
//  Created by davidjose gutierrez calderon  on 10/3/17.
//
//

import Foundation
import Alamofire

class NetworkService {
    
    let api_key = "93aea0c77bc168d8bbce3918cefefa45"
    let base_url = "https://api.themoviedb.org/3/"
    let images_url = "https://image.tmdb.org/t/p/w500/"
    let discover_url = "discover/movie?api_key=%1$;language=en-US;sort_by=popularity.desc;include_adult=false;include_video=false;page="
    let search_url = "https://api.themoviedb.org/3/search/movie?api_key=%1$s&amp;language=en-US&amp;query=%2$s&amp;page=%3$s&amp;include_adult=false"
    
    let shared = NetworkService()
    
    
    
}
