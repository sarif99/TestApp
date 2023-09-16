//
//  Movie.swift
//  MovieList
//
//  Created by Shehroz Arif on 11/09/2023.
//

import Foundation

struct Movie: Codable {
    
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
    // Handle potential changes in the JSON response
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path
        case genre_ids
        case id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case release_date
        case title
        case video
        case vote_average
        case vote_count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        adult = try container.decode(Bool.self, forKey: .adult)
        backdrop_path = try? container.decode(String.self, forKey: .backdrop_path)
        genre_ids = try container.decode([Int].self, forKey: .genre_ids)
        id = try container.decode(Int.self, forKey: .id)
        original_language = try container.decode(String.self, forKey: .original_language)
        original_title = try container.decode(String.self, forKey: .original_title)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        poster_path = try? container.decode(String.self, forKey: .poster_path)
        release_date = try container.decode(String.self, forKey: .release_date)
        title = try container.decode(String.self, forKey: .title)
        video = try container.decode(Bool.self, forKey: .video)
        vote_average = try container.decode(Double.self, forKey: .vote_average)
        vote_count = try container.decode(Int.self, forKey: .vote_count)
    }
}


struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
