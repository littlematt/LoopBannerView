//
//  GuideViewCell.swift
//  BuyTicket
//
//  Created by Pro on 16/10/27.
//  Copyright © 2016年 Yuanzheng. All rights reserved.
//

import UIKit

class GuideViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String = "" {
        willSet{
            imageView.image = UIImage(named:newValue)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        imageView.layer.cornerRadius = 10
//        imageView.layer.masksToBounds = true
    }

}
