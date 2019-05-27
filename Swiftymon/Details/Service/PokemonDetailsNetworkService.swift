//
//  PokemonDetailNetworkService.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 26/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class PokemonDetailsNetworkService: PokemonDetailsService {
    
    private let pokemonId: String
    
    required init(pokemonId: String) {
        self.pokemonId = pokemonId
    }
    
    internal func fetchEvolution(path: String, completion: @escaping (Result<Evolution, ConnectionError>) -> Void) {
        
        Networking.sendRequest(with: path) { (result) in
            guard let data = try? result.get(), let evolution: Evolution = Networking.decode(data: data) else {
                completion(.failure(.couldNotGetDetails))
                return
            }
            completion(.success(evolution))
        }
        
    }
    
    func fetchDetails(path: String, completion: @escaping (Result<(PokemonDetails, Evolution?), ConnectionError>) -> Void) {
        
        Networking.sendRequest(with: path) { (result) in
            guard let data = try? result.get(), let details: PokemonDetails = Networking.decode(data: data) else {
                completion(.failure(.couldNotGetDetails))
                return
            }
            
            if let evolutionPath = details.evolutionChain?.url {
                //self is retained here else closure exits and API call is not completed
                self.fetchEvolution(path: evolutionPath, completion: { (evolutionResult) in
                    
                    guard let evolution = try? evolutionResult.get() else {
                        // could not fetch evolution, complete with details
                        completion(.success((details,nil)))
                        return
                    }
                    //complete with details and evolution
                    completion(.success((details, evolution)))
                })
            } else {
                // only fetched details, no evolution
                completion(.success((details,nil)))
            }
        }
        
    }
    
}
