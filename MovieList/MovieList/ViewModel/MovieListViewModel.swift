//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by Shehroz Arif on 10/09/2023.
//

import Foundation

protocol MovieListViewModelDelegate: AnyObject {
    func moviesLoaded()
    func showError(message: String)
}

class MovieListViewModel {
    
    private weak var delegate: MovieListViewModelDelegate?
    private let networkService: NetworkServiceProtocol
    private let movieDataManager: MovieDataManager
    
    private var allMovies: [MovieEntity] = []
    
    // Filtered movies based on search criteria
    private var filteredMovies: [MovieEntity] = [] {
        didSet {
            updateFilteredMovies?()
        }
    }
    
    // Property to hold the current search query
    var searchQuery: String = "" {
        didSet {
            filterMovies()
        }
    }
    
    // Callback to notify the view controller of changes in filteredMovies
    var updateFilteredMovies: (() -> Void)?
    
    init(networkService: NetworkServiceProtocol, movieDataManager: MovieDataManager) {
        self.networkService = networkService
        self.movieDataManager = movieDataManager
    }
    
    init(delegate: MovieListViewModelDelegate, networkService: NetworkServiceProtocol, movieDataManager: MovieDataManager) {
        self.delegate = delegate
        self.networkService = networkService
        self.movieDataManager = movieDataManager
    }
    
    func fetchMovies() {
        // Attempt to fetch movies from the server using the network service
        networkService.fetchMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let movies):
                    // Save the fetched movies to Core Data
                    self.movieDataManager.saveMovies(movies.results)
                    // Update the allMovies array with the fetched data
                    self.allMovies = self.movieDataManager.fetchMovies()
                    // Set filteredMovies to allMovies initially
                    self.filteredMovies = self.allMovies
                    // Notify the delegate that movies have been loaded
                    self.delegate?.moviesLoaded()
                    
                case .failure(let error):
                    // If there's an error, attempt to load movies from Core Data
                    self.allMovies = self.movieDataManager.fetchMovies()
                    self.filteredMovies = self.allMovies
                    
                    if self.allMovies.isEmpty {
                        // If there are no movies in Core Data and there was an error with the network request, show an error message
                        self.delegate?.showError(message: error.localizedDescription)
                    } else {
                        // Notify the delegate that movies have been loaded from Core Data
                        self.delegate?.moviesLoaded()
                    }
            }
        }
    }
    
    
    func numberOfMovies() -> Int {
        return filteredMovies.count
    }
    
    func movie(at index: Int) -> MovieEntity {
        return filteredMovies[index]
    }
    
    func filterMovies() {
        if searchQuery.isEmpty {
            filteredMovies = allMovies
        } else {
            filteredMovies = allMovies.filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
        }                
    }
}
