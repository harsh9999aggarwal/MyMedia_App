//
//  ApiDataCell.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import Foundation



class APICall {
    
    let session = URLSession.shared
    
    func request<T: Decodable>(_ url: URL, for dataType: T.Type , completion: @escaping (Result<T,Error>) -> Void )  {
        let sessionTask = session.dataTask(with: url ) { (data, response, error) in
            if let apiError = error{
                DispatchQueue.main.async {
                    completion(.failure(apiError))
                }
            } else if let apiData = data{
                do {
                    let parseData = try JSONDecoder().decode(dataType, from: apiData)
                    DispatchQueue.main.async {
                        completion(.success(parseData))
                    }
                }catch {
                    DispatchQueue.main.async {
                        completion(.failure(NSError.init(domain: "Failed To parse Data", code: 1, userInfo: nil)))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError.init(domain: "Some Error Occured", code: 1, userInfo: nil)))
                }
            }
        }
        sessionTask.resume()
    }
    
    func stopAllRequests() {
        session.invalidateAndCancel()
    }
    
}
