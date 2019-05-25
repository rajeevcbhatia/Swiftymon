//
//  PokemonListPresentable.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol PokemonListPresentable {
    var shouldNotifyOnSrollToEnd: Bool
    func attach(view: PokemonListView)
    func didScrollToLastRows()
}
