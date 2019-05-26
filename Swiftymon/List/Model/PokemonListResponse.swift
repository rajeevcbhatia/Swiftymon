//
//  PokemonListResponse.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

struct PokemonListResponse: Codable {
    let next: String?
    let results: [Pokemon]
}

// MARK: - Result
struct Pokemon: Codable {
    let name: String
    let url: String
    
    var imagePath: String {
        guard let id = id else {
            return "https://img.icons8.com/nolan/2x/pokeball.png"
        }
        
        return URLBuilder.pokemonImage(id: id).path
    }
    
    var id: String? {
        let urlString = url.hasSuffix("/") ? String(url.dropLast()) : url
        return urlString.components(separatedBy: "/").last
    }
}
