//
//  PokemonListPresenter.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class PokemonListPresenter: PokemonListPresentable {
    
    var shouldNotifyOnSrollToEnd = true
    
    weak private var pokemonListView: PokemonListView?
    
    private let pokemonListService: PokemonListService
    
    private var nextPagePath: String?
    
    init(pokemonListService: PokemonListService) {
        self.pokemonListService = pokemonListService
    }
    
    func attach(view: PokemonListView) {
        pokemonListView = view
        fetchNextPage()
    }
    
    func didScrollToLastRows() {
        fetchNextPage()
    }
    
    private func fetchNextPage() {
        shouldNotifyOnSrollToEnd = false
        
        pokemonListService.fetchNextPage(path: nextPagePath) { [weak self] (result) in
            guard let response = try? result.get() else {
                self?.shouldNotifyOnSrollToEnd = true
                return
            }
            
            let newItems = response.results
            self?.nextPagePath = response.next
            
            self?.shouldNotifyOnSrollToEnd = self?.nextPagePath != nil
            
            self?.pokemonListView?.addPokemon(items: newItems)
        }
        
    }
}
