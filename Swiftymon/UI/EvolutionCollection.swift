//
//  EvolutionCollectionView.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 27/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import SDWebImage

protocol EvolutionCollectionDelegate: AnyObject {
    func didSelect(pokemon: Pokemon)
}

class EvolutionCollection: UICollectionView {
    
    weak var evolutionCollectionDelegate: EvolutionCollectionDelegate?
    
    var viewModel: EvolutionCollectionViewModel? {
        didSet {
            reloadData()
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        registerCells()
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerCells()
        dataSource = self
        delegate = self
    }
    
    private func registerCells() {
        register(UINib(nibName: ImageAndTextCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageAndTextCollectionViewCell.identifier)
    }
    
}

extension EvolutionCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ImageAndTextCollectionViewCell.identifier, for: indexPath) as! ImageAndTextCollectionViewCell
        let pokemon = viewModel?.items[indexPath.item]
        let id = pokemon?.id ?? ""
        cell.imgView.sd_setImage(with: URL(string: URLBuilder.pokemonImage(id: id).path), completed: nil)
        cell.textLabel.text = pokemon?.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: frame.height - 20, height: frame.height - 20)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let pokemon = viewModel?.items[indexPath.item] else { return }
        
        evolutionCollectionDelegate?.didSelect(pokemon: pokemon)
    }
}

struct EvolutionCollectionViewModel {
    
    let items: [Pokemon]
    
    init(from evolution: Evolution) {
        var pokemon = [Pokemon]()
        var chain: Chain? = evolution.chain
        while let unwrappedChain = chain {
            pokemon.append(unwrappedChain.species)
            chain = unwrappedChain.evolvesTo?.first
        }
        items = pokemon
    }
    
}
