//
//  BeerCollectionViewCell.swift
//  VIP_01_Beers
//
//  Created by jfuentescasillas on 06/07/23.
//


import UIKit


class BeerCollectionViewCell: UICollectionViewCell {
    static let reuseID: String = "BeerCell"
    
    let avatarImageView = UIImageView()
    let beerNameLbl = BeersTitleLabel(textAlignment: .center, fontSize: 16)
}
