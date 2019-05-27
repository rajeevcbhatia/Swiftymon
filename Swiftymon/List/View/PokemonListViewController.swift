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
        pokemonListTableView.register(UINib(nibName: PokemonListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PokemonListTableViewCell.identifier)
        }
        
    }
    
    private let presenter: PokemonListPresentable
    private var pokemonListViewModel = PokemonListViewModel()
    
    required init(presenter: PokemonListPresentable) {
        self.presenter = presenter
        super.init(nibName: String(describing: PokemonListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
    }

}

extension PokemonListViewController: PokemonListView {
    
    func addPokemon(items: [Pokemon]) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let strongSelf = self else { return }
            
            let currentCount = strongSelf.pokemonListViewModel.count
            
        
            strongSelf.pokemonListViewModel.items.append(contentsOf: items)
            
            let newIndexPaths = (currentCount ..< currentCount + items.count).map { IndexPath(row: $0, section: 0) }
            
            strongSelf.pokemonListTableView.beginUpdates()
            strongSelf.pokemonListTableView.insertRows(at: newIndexPaths, with: .fade)
            
        strongSelf.pokemonListTableView.setContentOffset(strongSelf.pokemonListTableView.contentOffset, animated: false)//to fix jump on insert rows
            strongSelf.pokemonListTableView.endUpdates()
        }
    }
    
    func goToDetails(id: String) {
        let detailsService = PokemonDetailsNetworkService(pokemonId: id)
        let detailsPresenter = PokemonDetailsPresenter(pokemonDetailsService: detailsService)
        let detailsVC = PokemonDetailsViewController(presenter: detailsPresenter)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        let isInLast50 = indexPaths.contains(where: { (indexPath) -> Bool in
            indexPath.row >= pokemonListViewModel.count - 50
        })
        
        if isInLast50 && presenter.shouldNotifyOnSrollToEnd {
            presenter.didScrollToLastRows()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let pokemonCell = tableView.dequeueReusableCell(withIdentifier: PokemonListTableViewCell.identifier, for: indexPath) as? PokemonListTableViewCell else { return UITableViewCell() }
        
        let currentPokemon = pokemonListViewModel.items[indexPath.row]
       
        pokemonCell.pokemon = currentPokemon
        
        return pokemonCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonListViewModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return pokemonListViewModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let id = pokemonListViewModel.items[indexPath.row].id else {
            return
        }
        
        presenter.didSelectPokemon(id: id)
    }
}
