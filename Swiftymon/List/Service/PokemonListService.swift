//
//  PokemonListService.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol PokemonListService {
    
    func fetchNextPage(path: String?, completion: @escaping (Result<PokemonListResponse, ConnectionError>) -> Void)
    
}
