//
//  MockPokemonListService.swift
//  SwiftymonTests
//
//  Created by Rajeev Bhatia on 26/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
@testable import Swiftymon

enum MockListPageTypes: String {
    case first
    case pageWithNext
    case pageWithoutNext
    case failure
}

class MockPokemonListService: PokemonListService {
    
    func fetchNextPage(path: String?, completion: @escaping (Result<PokemonListResponse, ConnectionError>) -> Void) {
        
        if path == MockListPageTypes.failure.rawValue {
            completion(.failure(.couldNotGetDetails))
            return
        }
        
        let next = (path == MockListPageTypes.pageWithoutNext.rawValue) ? nil : "next"
        
        let pokemon = (1..<40).map { "\($0)" }.map { Pokemon.init(name: $0, url: URLBuilder.pokemonImage(id: $0).path) }
        
        let response = PokemonListResponse(next: next, results: pokemon)
        
        completion(.success(response))
        
    }
    
    private func getPokemon(from index: Int) {
        
    }
}
