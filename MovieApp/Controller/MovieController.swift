//
//  MovieController.swift
//  MovieApp
//
//  Created by Mac Pro on 27/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation

class MovieController{
    
    var movieAPI = MovieAPI()
    var arrayMovieDB: [Movie] = []
    var page: Int = 1
    
    func getMoviesAPI(page: Int,completion: @escaping (Bool)-> Void){
        self.page = page
        movieAPI.getMoviesDB(page: page) { (moviesDB, error) in
            if error != nil{
                completion(false)
                print("Deu ruim")
            }else{
                self.arrayMovieDB.append(contentsOf: moviesDB?.results ?? [])
                completion(true)
            }
        }
        
    }
    
    func getLocalMovie() -> MovieController? {
        
        if let path = Bundle.main.path(forResource: "movie", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let movie = try? JSONDecoder().decode(MovieRequest.self, from: data)
                
                self.arrayMovieDB = movie?.results ?? []
                
                return self
                
            } catch {
                return nil
            }
        }
        return nil
    }
    
    
}
