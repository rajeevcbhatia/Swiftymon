//
//  PokemonListTableViewCell.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import SDWebImage

class PokemonListTableViewCell: UITableViewCell {
    
    static let identifier = "PokemonListTableViewCell"
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: PokemonListItem? {
        didSet {
            guard let pokemon = pokemon else { return }
            pokemonImageView?.sd_setImage(with: URL(string: pokemon.imagePath), completed: nil)
            nameLabel.text = pokemon.name
        }
    }
    
}
