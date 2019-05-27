//
//  ImageAndTextCollectionViewCell.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 27/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class ImageAndTextCollectionViewCell: UICollectionViewCell {

    static let identifier = "ImageAndTextCollectionViewCell"
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
}
