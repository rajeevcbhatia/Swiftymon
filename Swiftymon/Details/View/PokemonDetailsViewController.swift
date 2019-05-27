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
    
}
