//
//  MovieDataModel.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import Foundation


struct HomeData {
    let sectionTitle: String?
    let movieData: [MovieData]?
}

struct MainData: Decodable {
//    let page: Int?
    let results: [MovieData]?
//    let total_pages, total_results: Int?
}

// MARK: - Result
struct MovieData: Decodable {

    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_language: String?
    let original_title, overview: String?
    let popularity: Double?
    let poster_path, release_date, title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
    
}
