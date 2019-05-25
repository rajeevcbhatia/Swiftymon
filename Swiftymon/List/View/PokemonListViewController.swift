//
//  PokemonListViewController.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import SDWebImage

class PokemonListViewController: BaseViewController {
    
    @IBOutlet weak var pokemonListTableView: UITableView! {
        
        didSet {
            pokemonListTableView.dataSource = self
            pokemonListTableView.delegate = self
            pokemonListTableView.prefetchDataSource = self
        }
        
    }
    
    private let presenter: PokemonListPresentable
    private var pokemonListViewModel = PokemonListViewModel()
    
    init(presenter: PokemonListPresentable) {
        self.presenter = presenter
        super.init(nibName: String(describing: PokemonListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.attach(view: self)
    }

}

extension PokemonListViewController: PokemonListView {
    
    func addPokemon(items: [PokemonListItem]) {
        let currentCount = pokemonListViewModel.count
        
        pokemonListViewModel.items.append(contentsOf: items)
        
        var newIndexPaths = (currentCount ..< currentCount + items.count).map { IndexPath(row: $0, section: 0) }
        
        pokemonListTableView.beginUpdates()
        pokemonListTableView.insertRows(at: newIndexPaths, with: .bottom)
    }
    
}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        if presenter.shouldNotifyOnSrollToEnd {
            presenter.didScrollToLastRows()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemonCell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        
        let currentPokemon = pokemonListViewModel.items[indexPath.row]
        
        pokemonCell.imageView?.sd_setImage(with: URL(string: currentPokemon.imagePath), completed: nil)
        pokemonCell.textLabel?.text = currentPokemon.name
        
        return pokemonCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonListViewModel.count
    }
    
}
