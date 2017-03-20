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
    
    init() {
        self.films = [Film]()
        self.actualPage = 1
    }
    
    func fetchDiscoverFilms(completion: @escaping () -> Void, errorHandler: @escaping (String) -> Void){
        NetworkService.shared.discoverMovies(page: actualPage, completionHandler: { films in
            self.films.append(contentsOf: films)
            self.actualPage = self.actualPage + 1
            completion()
        }, errorHandler: {error in
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
        return films[at].poster_path
    }
}
