//
//  PokemonListResponse.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let results: [PokemonListItem]
}

// MARK: - Result
struct PokemonListItem: Codable {
    let name: String
    let url: String
    
    var imagePath: String {
        return ""
    }
    
    var id: String? {
        return url.components(separatedBy: "/").last
    }
}
