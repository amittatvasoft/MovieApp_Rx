//
//  HomeMovieCollectionViewCell.swift
//  RxMovieApp_Amit
//
//  Created by mac104 on 1/10/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import UIKit
import FSPagerView
class HomeMovieCollectionViewCell: FSPagerViewCell {

    @IBOutlet weak private var lblPreSale  : UILabel!
    @IBOutlet weak private var vwBuyTicket : UIView!
    @IBOutlet weak private var imgVwPoster : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code


        self.layer.cornerRadius = 7.5
        self.clipsToBounds = true
    }

    func configure(movie: Movie){
        self.imgVwPoster.downloadImageWithCaching(with: movie.posterPath ?? "")
        self.lblPreSale.isHidden = !(movie.presaleFlag ?? 0 == 1)
    }
}
