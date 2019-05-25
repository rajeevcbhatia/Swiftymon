//
//  PokemonListPresenter.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class PokemonListPresenter {
    
    var shouldNotifyOnSrollToEnd = true
    
    weak private var pokemonListView: PokemonListView?
    
    func attach(view: PokemonListView) {
        
        pokemonListView = view
        
    }
    
    func didScrollToLastRows() {
        shouldNotifyOnSrollToEnd = false
        print("did scroll to last rows")
    }
}
