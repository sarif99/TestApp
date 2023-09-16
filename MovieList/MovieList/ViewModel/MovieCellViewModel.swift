//
//  MovieCellViewModel.swift
//  MovieList
//
//  Created by Shehroz Arif on 11/09/2023.
//

import Foundation

struct MovieCellViewModel {
    let title: String
    let releaseDate: String
    let posterURL: URL?
    
    init(movie: MovieEntity) {
        title = movie.title
        releaseDate = "Release Date: " + (movie.releaseDate ?? "")
        if let posterPath = movie.posterPath {
            posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        } else {
            posterURL = nil
        }
    }
}
