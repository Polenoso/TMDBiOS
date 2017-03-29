//
//  FilmViewModel.swift
//  theiostmdb
//
//  Created by aitor pagan  on 14/3/17.
//
//

import Foundation
class FilmViewModel {
    private var films:[Film] = []
    private var actualPage: Int = -1
    var isLoading: Bool = false
    var oldQuery: String = ""
    
    init() {
        self.films = [Film]()
        self.actualPage = 1
    }
    
    func fetchDiscoverFilms(completion: @escaping () -> Void, errorHandler: @escaping (String) -> Void){
        isLoading = true
        NetworkService.shared.discoverMovies(page: actualPage, completionHandler: { films in
            if(films.count != 0){
                self.isLoading = false
                self.films.append(contentsOf: films)
                self.actualPage = self.actualPage + 1
                completion()
            }else{
                errorHandler("No more results")
            }
        }, errorHandler: {error in
            self.isLoading = false
            errorHandler(error)
        })
    }
    
    func fetchSearchFilms(query: String, completion: @escaping () -> Void, errorHandler: @escaping (String) -> Void){
        isLoading = true
        if(oldQuery != query){
            oldQuery = query
            actualPage = 1
            NetworkService.shared.stopRequests()
        }
        NetworkService.shared.searchMovies(query: oldQuery, page: actualPage, completionHandler: { films in
            self.isLoading = false
            if(self.actualPage == 1){self.films.removeAll()}
            if(films.count != 0){
                self.films.append(contentsOf: films)
                self.actualPage = self.actualPage + 1
                completion()
            }else{
                errorHandler("No more results")
            }
        }, errorHandler: {error in
            self.isLoading = false
            errorHandler(error)
        })
    }
    
    func numberOfRowsInSection(section: Int) -> Int{
        return films.count > 0 ? films.count : 0
    }
    
    func getTextForOverview(at: Int) -> String{
        return films[at].overview
    }
    
    func getPathForImage(at: Int) -> String{
        return (films[at].poster_path != nil ? films[at].poster_path! : "")
    }
}
