//
//  ApiConstants.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import Foundation

enum ApiConstants {
    
    case home(genre)
    case user
    case search(String)
    
    enum genre: String, CaseIterable {
        
        case banner = "Banner"
        case popularity = "Popularity"
        case bestDrama = "Best Drama"
        case kidsMovies = "Kids Movies"
        case bestMovies = "Best Movies"
        
    }
    var finalUrl: String{
        return baseUrl + endUrl + apiKey
    }
    
    var baseUrl: String {
        switch self {
        case .home(_), .search(_):
            return "https://api.themoviedb.org/3/"
        case .user:
            return ""
        
        }
    }
    var endUrl: String {
        switch self {
        case .home(let genre):
            switch  genre {
            case .banner:
                return "trending/movie/day?"
            case .popularity:
                return "discover/movie?sort_by=popularity.desc"
            case .bestDrama:
                return "discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10"
            case .kidsMovies:
                return "discover/movie?certification_country=US&certification.lte=G&sort_by=vote_average.desc"
            case .bestMovies:
                return "discover/movie?primary_release_year=2010&sort_by=vote_average.desc"
            }
        case .user:
            return ""
        case .search(let query):
            let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? query
            return "search/movie?&query=" + encodedQuery
            
        }
    }
    var apiKey: String {
        
        switch self {
        case .home(_), .search(_):
            return "&api_key=820016b7116f872f5f27bf56f9fdfb66"
        case .user:
            return ""
        
        }
    }
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}
