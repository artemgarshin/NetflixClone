//
//  APICaller.swift
//  NetflixClone
//
//  Created by Артем Гаршин on 18.12.2023.
//

import Foundation


struct Constants{
    static let API_KEY = "de6b0465b9be3d850fca86802a5c880c"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError{
    case failedTogetData
}


class APICaller{
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _,error in
            guard let data = data, error == nil else{
                return
            }
            
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch  {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
