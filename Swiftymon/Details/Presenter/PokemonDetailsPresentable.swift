//
//  PokemonDetailsPresentable.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 27/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol PokemonDetailsPresentable {
    
    init(pokemonDetailsService: PokemonDetailsService)
    
    func attach(view: PokemonDetailsView)
    
}
