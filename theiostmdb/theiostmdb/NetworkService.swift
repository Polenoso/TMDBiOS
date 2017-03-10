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
    let search_url = "https://api.themoviedb.org/3/search/movie?api_key=71fbe398f71c98f66552653199f9f592&language=en-US&query=%2$s&page=%3$s&amp;include_adult=false"
    
    static let shared : NetworkService = NetworkService()
    
    func discoverMovies(completionHandler: @escaping ([Film]) -> Void){
         print("thread: \(Thread.current) is main thread: \(Thread.isMainThread)")
            Alamofire.request("\(self.base_url)\(self.discover_url)",method: .get,parameters: self.discoverParams(),encoding: JSONEncoding.default, headers:nil).responseJSON(completionHandler:{ (response) in
                print("Parsing thread: \(Thread.current) is main thread: \(Thread.isMainThread)")
                let object = response.result.value as! [String : Any]
                let results = object["results"] as! [[String: Any]]
                var films = [Film]()
                for i in 0..<results.count{
                    films.append(Film.init(dictionary: results[i] as [String : AnyObject]))
                }
                DispatchQueue.main.async {
                    print("Response thread: \(Thread.current) is main thread: \(Thread.isMainThread)")
                    completionHandler(films)
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
    
    func discoverParams() -> Dictionary<String,Any>{
        let params: Dictionary<String, Any> = [
        "api_key" : "\(self.api_key)",
        "language" : "en-US",
        "sort_by" : "popularity.desc",
        "include_adult" : "false",
        "page" : "1"
            ]
        return params
    }
    
}
