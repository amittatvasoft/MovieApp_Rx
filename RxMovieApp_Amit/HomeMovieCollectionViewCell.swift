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

    @IBOutlet weak var buyTktBottomConstraint: NSLayoutConstraint!

    override var isSelected: Bool{
        didSet{
            if isSelected{
//                let oldFrame = vwBuyTicket.frame
//                var newFrame = oldFrame
//                newFrame.origin.y = newFrame.origin.y + 40
//                self.vwBuyTicket.frame = newFrame
                self.vwBuyTicket.isHidden = false
                buyTktBottomConstraint.constant = 30
                self.vwBuyTicket.layoutIfNeeded()
            }else{
                vwBuyTicket.isHidden = true
                buyTktBottomConstraint.constant = 0
                self.vwBuyTicket.layoutIfNeeded()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code


        self.layer.cornerRadius = 7.5
        self.clipsToBounds = true
    }

    func configure(movie: Movie){
        vwBuyTicket.isHidden = true
        self.contentView.layer.shadowColor = UIColor.clear.cgColor
        self.imgVwPoster.downloadImageWithCaching(with: movie.posterPath ?? "")
        self.lblPreSale.isHidden = !(movie.presaleFlag ?? 0 == 1)
    }
}
