//
//  PokemonListPresentable.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol PokemonListPresentable {
    
    var pokemonListService: PokemonListService { get }
    
    var nextPagePath: String? { get }
    
    init(pokemonListService: PokemonListService)
    
    var shouldNotifyOnSrollToEnd: Bool { get set }
    func attach(view: PokemonListView)
    func didScrollToLastRows()
}
