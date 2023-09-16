//
//  MovieListViewModelTests.swift
//  MovieListTests
//
//  Created by Shehroz Arif on 12/09/2023.
//

import XCTest
@testable import MovieList


class MovieListViewModelTests: XCTestCase {
    
    var viewModel: MovieListViewModel!
    private var mockNetworkService: MockNetworkService!
    private var mockMovieDataManager: MovieDataManager!

    
    override func setUp() {
        super.setUp()
        
        // Initialize the view model
        mockNetworkService = MockNetworkService()
        let testDBManager = TestDBManager()
        mockMovieDataManager = MovieDataManager(context: testDBManager.persistentContainer.viewContext)
        viewModel = MovieListViewModel(networkService: mockNetworkService, movieDataManager: mockMovieDataManager)
        
    }
    
    override func tearDown() {
        // Clean up any resources if needed
        viewModel = nil
        mockNetworkService = nil
        mockMovieDataManager = nil
        super.tearDown()
    }
    
    func testFetchMovies_Success() {
        // Arrange
        // Load test data from the JSON file
        guard let data = loadTestData(named: "test-tmdb") else {
            XCTFail("Failed to load test data")
            return
        }
        
        // Decode the test data into MovieResponse
        let decoder = JSONDecoder()
        guard let movieResponse = try? decoder.decode(MovieResponse.self, from: data) else {
            XCTFail("Failed to decode test data")
            return
        }
        
        // Set up the mock network service to return success with the test data
        mockNetworkService.mockFetchMoviesResult = .success(movieResponse)
                
        // Act
        viewModel.fetchMovies()
        
        // Assert
        XCTAssertEqual(viewModel.numberOfMovies(), 2)
    }
    
    
    func testFetchMovies_Failure() {
        // Arrange
        let mockError = NetworkError.noData
        
        // Stub the NetworkServiceProtocol to return the mockError
        mockNetworkService.mockFetchMoviesResult = .failure(mockError)
        
        // Act
        viewModel.fetchMovies()
        
        // Assert
        XCTAssertEqual(viewModel.numberOfMovies(), 0)        
    }
    
    func testFilterMovies() {
        // Load test data from the JSON file
        guard let data = loadTestData(named: "test-tmdb") else {
            XCTFail("Failed to load test data")
            return
        }
        
        // Decode the test data into MovieResponse
        let decoder = JSONDecoder()
        guard let movieResponse = try? decoder.decode(MovieResponse.self, from: data) else {
            XCTFail("Failed to decode test data")
            return
        }
        
        // Set up the mock network service to return success with the test data
        mockNetworkService.mockFetchMoviesResult = .success(movieResponse)
                
        viewModel.fetchMovies()
        
        // Filter movies with a search query
        viewModel.searchQuery = "M"
        
        // Assert that only one movie matches the search query
        XCTAssertEqual(viewModel.numberOfMovies(), 1)
        
        // Reset the search query
        viewModel.searchQuery = ""
        
        // Assert that all movies are displayed
        XCTAssertEqual(viewModel.numberOfMovies(), 2)
    }
    
    // Helper method to load test data from a JSON file
    private func loadTestData(named fileName: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        if let url = testBundle.url(forResource: fileName, withExtension: "json") {
            return try? Data(contentsOf: url)
        }
        return nil
    }
}

class MockNetworkService: NetworkServiceProtocol {
    
    var mockFetchMoviesResult: Result<MovieResponse, Error>?    
    
    func fetchMovies(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        
        if let result = mockFetchMoviesResult {
            completion(result)
        }
    }
}
