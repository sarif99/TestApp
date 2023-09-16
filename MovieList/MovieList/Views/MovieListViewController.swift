//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Shehroz Arif on 10/09/2023.
//

import UIKit

class MovieListViewController: UIViewController, MovieListViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    private var viewModel: MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        
        let networkService = NetworkService()
        let movieDataManager = MovieDataManager(context: DBManager.shared.viewContext)
        
        viewModel = MovieListViewModel(delegate: self, networkService: networkService, movieDataManager: movieDataManager)
        viewModel.fetchMovies()
        viewModel.updateFilteredMovies = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }            
        }
        
        // Set the delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        
        searchBar.delegate = self
    }
    
    func moviesLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        // Show an error message to the user
        AlertUtility.showAlert(title: "Error", message: message, viewController: self)
    }
    
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let movie = viewModel.movie(at: indexPath.row)
        let cellViewModel = MovieCellViewModel(movie: movie)
        cell.configure(with: cellViewModel)
        return cell                
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movie(at: indexPath.row)
        
        // Create an instance of MovieDetailViewController
        if let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            // Push or present the detail view controller
            movieDetailViewController.movie = selectedMovie
            navigationController?.pushViewController(movieDetailViewController, animated: true)
        }
    }
}

extension MovieListViewController: UISearchBarDelegate {
    
    // UISearchBarDelegate method to handle text input
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchQuery = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
