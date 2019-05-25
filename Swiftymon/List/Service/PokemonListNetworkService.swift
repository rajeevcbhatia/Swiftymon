//
//  PokemonListNetworkService.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class PokemonListNetworkService: PokemonListService {
    
    func fetchNextPage(path: String?, completion: @escaping (Result<PokemonListResponse, ConnectionError>) -> Void) {
        
        let path = path ?? URLBuilder.pokemonSpecies.path
        
        Networking.sendRequest(with: path) { (result) in
            
            guard let responseData = try? result.get(), let pokemonListResponse: PokemonListResponse = Networking.decode(data: responseData) else {
                completion(.failure(ConnectionError.couldNotGetDetails))
                return
            }
            completion(.success(pokemonListResponse))
            
        }
        
    }
    
}
