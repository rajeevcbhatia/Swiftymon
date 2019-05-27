//
//  PokemonDetailService.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 26/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol PokemonDetailsService {
    
    init(pokemonId: String)
    
    func fetchDetails(path: String, completion: @escaping (Result<(PokemonDetails, Evolution?), ConnectionError>) -> Void)
    func fetchEvolution(path: String, completion: @escaping (Result<Evolution, ConnectionError>) -> Void)
    
}
