//
//  Model.swift
//  Day3Homework
//
//  Created by Hina KONISHI on 2024/01/13.
//

import Foundation

struct User: Codable {
    let success: Bool
    let status_code: Int
    let status_message: String
}

struct Popular: Codable {
    let page: Int
    let results: [Results]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    struct Results: Codable, Identifiable{
        
        let adult: Bool
        let backdropPath: String
        let genreIDS: [Int]
        let id: Int
        let originalLanguage: String
        let originalTitle, overview: String
        let popularity: Double
        let posterPath, releaseDate, title: String
        let video: Bool
        let voteAverage: Double
        let voteCount: Int
        
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}
