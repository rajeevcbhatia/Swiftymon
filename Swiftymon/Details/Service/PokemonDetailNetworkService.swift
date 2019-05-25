//
//  PokemonDetailNetworkService.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 26/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class PokemonDetailNetworkService: PokemonDetailService {
    
    func fetchEvolution(path: String, completion: @escaping (Result<Evolution, ConnectionError>) -> Void) {
        
        Networking.sendRequest(with: path) { (result) in
            guard let data = try? result.get(), let evolution: Evolution = Networking.decode(data: data) else {
                completion(.failure(.couldNotGetDetails))
                return
            }
            print(evolution)
        }
        
    }
    
    func fetchDetails(path: String, completion: @escaping (Result<PokemonDetails, ConnectionError>) -> Void) {
        
        Networking.sendRequest(with: path) { [weak self] (result) in
            guard let data = try? result.get(), let details: PokemonDetails = Networking.decode(data: data) else {
                completion(.failure(.couldNotGetDetails))
                return
            }
            
            if let evolutionPath = details.evolutionChain?.url {
                self?.fetchEvolution(path: evolutionPath, completion: { (evolutionResult) in
                    
                })
            }
        }
        
    }
    
}
