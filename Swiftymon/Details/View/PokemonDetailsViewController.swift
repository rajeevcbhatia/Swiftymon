//
//  PokemonDetailsViewController.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 27/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: BaseViewController {
    
    private let presenter: PokemonDetailsPresentable
    
    @IBOutlet weak var flavorLabel: UILabel!
    
    @IBOutlet weak var evolutionCollection: EvolutionCollection! {
        didSet {
            evolutionCollection.evolutionCollectionDelegate = self
        }
    }
    
    required init(presenter: PokemonDetailsPresentable) {
        self.presenter = presenter
        super.init(nibName: String(describing: PokemonDetailsViewController.self), bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
    }
   
}

extension PokemonDetailsViewController: PokemonDetailsView {
    func didFetch(detailsWithEvolution: DetailsWithEvolution) {
        
        title = detailsWithEvolution.details.name.capitalized
        
        let flavorText = detailsWithEvolution.details.flavorText
        flavorLabel.text = flavorText
        
        if let evolution = detailsWithEvolution.evolution, let evolvesTo = evolution.chain.evolvesTo, evolvesTo.count > 0 {
            evolutionCollection.isHidden = false
            evolutionCollection.viewModel = EvolutionCollectionViewModel(from: evolution)
        }
    }
}

extension PokemonDetailsViewController: EvolutionCollectionDelegate {
    func didSelect(pokemon: Pokemon) {
        print(pokemon)
    }
}
