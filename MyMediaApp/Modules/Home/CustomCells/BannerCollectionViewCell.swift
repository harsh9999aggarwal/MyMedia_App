//
//  BannerCollectionViewCell.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customBannerImageView: UIImageView!
    @IBOutlet weak var customBannerLabel: UILabel!
    
    static let identifier = "BannerCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BannerCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customBannerLabel.layer.cornerRadius = 15
        customBannerLabel.clipsToBounds = true
        customBannerImageView.layer.cornerRadius = 30
        customBannerImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
           customBannerImageView.image = nil
           customBannerLabel.text = ""
       }
    
    func configure(_ data: MovieData?){
        
        if let posterPath = data?.backdrop_path, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath){
            customBannerImageView.downloadedFrom(url: url)
        }
        customBannerLabel.text = ("  \(data?.title ?? "")  ")
        
    }

}
