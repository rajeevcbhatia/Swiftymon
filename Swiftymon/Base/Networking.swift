//
//  Networking.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class Networking {
    
    static func sendRequest(with url: URL, completion: @escaping (Result<Data, ConnectionError>) -> Void) {
        
        let urlSesion = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = urlSesion.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.couldNotGetDetails))
                return
            }
            
            completion(.success(data))
            
        }
        
        task.resume()
        
    }
    
    static func decode<T: Codable>(data: Data) -> T? {
        
        let decoder = JSONDecoder()
        let result = try? decoder.decode(T.self, from: data)
        return result
        
    }
    
}
