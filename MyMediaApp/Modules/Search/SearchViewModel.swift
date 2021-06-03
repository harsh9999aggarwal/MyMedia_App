//
//  SearchViewModel.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    var searchApiData: [MovieData]?
    
    func fetchSearchApiData(searchString: String, completion: @escaping (Bool,String) -> Void){
        
        searchApiData?.removeAll()
        NetworkManager().fetchTheMovieDBData(urlType: .search(searchString)) { (result) in
            switch result{
            case .success(let data):
                self.searchApiData = data.results
                completion(true, "")
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
}
