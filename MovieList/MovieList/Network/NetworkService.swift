//
//  NetworkService.swift
//  MovieList
//
//  Created by Shehroz Arif on 11/09/2023.
//

protocol NetworkServiceProtocol {
    func fetchMovies(completion: @escaping (Result<MovieResponse, Error>) -> Void)
}

import Foundation

//TODO: Add YOUR_STATIC_TMDB_AUTH_TOKEN
private let authToken: String = ""

class NetworkService: NetworkServiceProtocol {
            
    func fetchMovies(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        
        let headers = TMDBEndpoint.popularMovies.headers
        let popularMoviesURL = TMDBEndpoint.popularMovies.url
        let request = NSMutableURLRequest(url: popularMoviesURL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                // Decode the JSON response into a MovieResponse object
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(movieResponse))
            } catch {
                completion(.failure(error))
            }
        })
        
        dataTask.resume()
    }
}

enum NetworkError: Error {
    case noData
    // Add more error cases as needed
}


enum TMDBEndpoint {
    
    case popularMovies
    
    var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
            case .popularMovies:
                return "/3/movie/popular"
        }
    }
    
    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(authToken)"
        ]
    }
    
    var url: URL {
        var components = URLComponents(string: baseURL)!
        components.path = path
        return components.url!
    }
}
