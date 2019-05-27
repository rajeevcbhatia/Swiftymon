//
//  PokemonDetailsPresenter.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 27/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class PokemonDetailsPresenter: PokemonDetailsPresentable {
    
    private let pokemonDetailsService: PokemonDetailsService
    weak private var pokemonDetailsView: PokemonDetailsView?
    
    required init(pokemonDetailsService: PokemonDetailsService) {
        self.pokemonDetailsService = pokemonDetailsService
    }
    
    func attach(view: PokemonDetailsView) {
        self.pokemonDetailsView = view
    }
    
    
    
    
}
