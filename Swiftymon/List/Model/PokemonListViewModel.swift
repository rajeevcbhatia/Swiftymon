//
//  PokemonListViewModel.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
import CoreGraphics

struct PokemonListViewModel {
    
    let pokemonCellIdentifier = "pokemonCellIdentifier"
    let rowHeight: CGFloat = 100
    
    var count: Int {
        return items.count
    }
    
    var items =  [PokemonListItem]()
    
}
