//
//  MovieDataManager.swift
//  MovieList
//
//  Created by Shehroz Arif on 11/09/2023.
//

import Foundation
import CoreData

class MovieDataManager {
    
    private let managedContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.managedContext = context
    }
    
    // Fetch movies
    func fetchMovies() -> [MovieEntity] {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        do {
            let movies = try managedContext.fetch(fetchRequest)
            return movies
        } catch {
            return []
        }
    }
    
    // Create a new movie
    func createMovie() -> MovieEntity {
        return MovieEntity(context: managedContext)
    }
    
    func saveMovies(_ movieData: [Movie]) {
        
        // Remove all existing Movie entities from Core Data
        removeAllMovies()
        
        for movieInfo in movieData {
            let movie = MovieEntity(context: managedContext)
            movie.title = movieInfo.title
            movie.releaseDate = movieInfo.release_date
            movie.posterPath = movieInfo.poster_path
            
            do {
                try managedContext.save()
            } catch {
                print("Error saving movie data: \(error.localizedDescription)")
            }
        }
    }
    
    // Remove all Movie entities from Core Data
    private func removeAllMovies() {
        
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do {
            let movies = try managedContext.fetch(fetchRequest)
            
            for movie in movies {
                managedContext.delete(movie)
            }
            
            try managedContext.save()
        } catch {
            print("Error removing existing movies: \(error.localizedDescription)")
        }
    }
}
