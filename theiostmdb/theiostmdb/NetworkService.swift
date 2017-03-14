//
//  NetworkService.swift
//  theiostmdb
//
//  Created by davidjose gutierrez calderon  on 10/3/17.
//
//

import Foundation
import Alamofire

class NetworkService : NSObject {
    
    let api_key = "71fbe398f71c98f66552653199f9f592"
    let base_url = "https://api.themoviedb.org/3/"
    let images_url = "https://image.tmdb.org/t/p/w500/"
    let discover_url = "discover/movie?api_key=71fbe398f71c98f66552653199f9f592&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
    let discover_url2 = "discover/movie"
    let search_url = "https://api.themoviedb.org/3/search/movie?api_key=71fbe398f71c98f66552653199f9f592&language=en-US&query=%2$s&page=%3$s&amp;include_adult=false"
    
    static let shared : NetworkService = NetworkService()
    
    func discoverMovies(page: Int, completionHandler: @escaping ([Film]) -> Void, errorHandler: @escaping (String) -> Void){
        Alamofire.request("\(self.base_url)\(self.discover_url2)", method: .get,parameters: self.discoverParams(page: page),encoding: URLEncoding.default, headers:nil).responseJSON(completionHandler:{ (response) in
                NSLog("DiscoverRequest Reached")
                let object = response.result.value as! [String : Any]
            if let results = object["results"] as? [[String: Any]]{
                var films = [Film]()
                for i in 0..<results.count{
                    films.append(Film.init(dictionary: results[i] as [String : AnyObject]))
                }
                DispatchQueue.main.async {
                    print("Response thread: \(Thread.current) is main thread: \(Thread.isMainThread)")
                    completionHandler(films)
                }
            }else{
                errorHandler(String(describing: response.result.value));
            }
            
        })
    }
    
    
    func convertToDictionary(text: String) -> [[String: Any]]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func discoverParams(page : Int) -> Dictionary<String,AnyObject>{
        let params: Dictionary<String, AnyObject> = [
        "api_key" : self.api_key as AnyObject,
        "language" : "en-US" as AnyObject,
        "sort_by" : "popularity.desc" as AnyObject,
        "include_adult" : "false" as AnyObject,
        "page" : String(page) as AnyObject
            ]
        return params
    }
    
}
