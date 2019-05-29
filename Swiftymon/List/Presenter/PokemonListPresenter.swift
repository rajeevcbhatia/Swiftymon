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
    
    internal let pokemonListService: PokemonListService
    
    var nextPagePath: String?
    
    required init(pokemonListService: PokemonListService) {
        self.pokemonListService = pokemonListService
    }
    
    func attach(view: PokemonListView) {
        pokemonListView = view
        pokemonListView?.showLoader()
        fetchNextPage()
    }
    
    func didScrollToLastRows() {
        fetchNextPage()
    }
    
    private func fetchNextPage() {
        shouldNotifyOnSrollToEnd = false
        
        pokemonListService.fetchNextPage(path: nextPagePath) { [weak self] (result) in
            self?.pokemonListView?.hideLoader()
            guard let response = try? result.get() else {
                self?.showAlertWithRetry()
                self?.shouldNotifyOnSrollToEnd = true
                return
            }
            
            let newItems = response.results
            self?.nextPagePath = response.next
            
            self?.shouldNotifyOnSrollToEnd = self?.nextPagePath != nil
            
            self?.pokemonListView?.addPokemon(items: newItems)
        }
        
    }
    
    func didSelectPokemon(id: String) {
        pokemonListView?.goToDetails(id: id)
    }
    
    private func showAlertWithRetry() {
        pokemonListView?.showRetryAlert(title: "Alert", message: "Could not fetch data. Please try again", callback: { [weak self] in
            self?.pokemonListView?.showLoader()
            self?.fetchNextPage()
        })
    }
}
