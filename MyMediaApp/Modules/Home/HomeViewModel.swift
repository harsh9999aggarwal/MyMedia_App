//
//  HomeViewModel.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import Foundation


class HomeViewModel {
    
    var homeApiData: [HomeData] = []
    
    func fetchHomeApiData(completion: @escaping (Bool,String) -> Void){
        
        homeApiData.removeAll()
        for genre in ApiConstants.genre.allCases {
            NetworkManager().fetchTheMovieDBData(urlType: .home(genre)) { (result) in
                switch result{
                case .success(let data):
                    if genre == .banner {
                        self.homeApiData.insert(HomeData(sectionTitle: genre.rawValue, movieData: data.results), at: 0)
                    } else {
                        self.homeApiData.append(HomeData(sectionTitle: genre.rawValue, movieData: data.results))
                    }
                    completion(true, "")
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
}
