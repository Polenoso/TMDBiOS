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
    
    func fetchDiscoverFilms(completion: () -> Void, errorHandler: @escaping (String) -> Void){
        NetworkService.shared.discoverMovies(page: actualPage, completionHandler: { films in
            self.films.append(contentsOf: films)
            self.actualPage = self.actualPage + 1
        }, errorHandler: {error in
            errorHandler(error)
        })
    }
    
}
