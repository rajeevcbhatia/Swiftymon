//
//  EvolutionCollectionView.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 27/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import SDWebImage

class EvolutionCollection: UICollectionView {
    
    var evolution: Evolution?

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

extension EvolutionCollection: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ImageAndTextCollectionViewCell.identifier, for: indexPath) as! ImageAndTextCollectionViewCell
        cell.imgView.sd_setImage(with: URL(string: URLBuilder.pokemonImage(id: "\(indexPath.item)").path), completed: nil)
        return cell
    }
}
