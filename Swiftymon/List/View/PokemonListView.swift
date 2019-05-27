//
//  PokemonListView.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol PokemonListView: BaseView {
    
    init(presenter: PokemonListPresentable)
    func addPokemon(items: [Pokemon])
    
    func goToDetails(id: String)
}
