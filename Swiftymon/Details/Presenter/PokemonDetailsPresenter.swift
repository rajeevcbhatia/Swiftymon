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
        
        pokemonDetailsService.fetchDetails(path: URLBuilder.pokemonDetails(id: pokemonDetailsService.pokemonId).path) { [weak self] (result) in
            guard let response = try? result.get() else {
                view.showAlert(title: "Alert", message: "Could not fetch data")
                return
            }
            self?.pokemonDetailsView?.didFetch(detailsWithEvolution: response)
        }
    }
    
    
    
    
}
