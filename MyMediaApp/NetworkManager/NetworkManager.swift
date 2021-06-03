//
//  NetworkManager.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import Foundation

class NetworkManager {
    
    
    func fetchTheMovieDBData(urlType: ApiConstants, completion: @escaping (Result<MainData,Error>) -> Void){
        let url = URL(string: urlType.finalUrl)!
        APICall().request(url, for: MainData.self) { (result) in
            completion(result)
        }
    }
    
    func fetchUserData(urlType: ApiConstants, completion: @escaping (Result<[Int],Error>) -> Void){
        let url = URL(string: urlType.finalUrl)!
        APICall().request(url, for: [Int].self) { (result) in
            completion(result)
        }
    }
}
