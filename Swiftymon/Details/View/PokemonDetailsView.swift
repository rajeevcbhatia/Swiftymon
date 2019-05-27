//
//  PokemonDetailsView.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 27/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol PokemonDetailsView: BaseView {
    init(presenter: PokemonDetailsPresentable)
    
    func didFetch(detailsWithEvolution: DetailsWithEvolution)
}
