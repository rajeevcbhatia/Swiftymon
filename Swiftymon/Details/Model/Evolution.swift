//
//  Evolution.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 26/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

// MARK: - Evolution
struct Evolution: Codable {
    let chain: Chain
}

// MARK: - Chain
struct Chain: Codable {
    let evolvesTo: [Chain]?
    let species: Pokemon
    
    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
}
