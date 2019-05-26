//
//  URLConstants.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

enum UrlBase: String {
    case apiBase = "https://pokeapi.co/api/v2/"
    case pokemonSpecies = "pokemon-species"
    case imageBase = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
}

enum UrlParams: String {
    case offset
    case limit
}

enum UrlValues: String {
    case limit = "100"
    case offset = "0"
}
