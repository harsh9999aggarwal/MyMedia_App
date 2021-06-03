//
//  MainCollectionViewCell.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 28/04/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage : UIImageView!
    @IBOutlet weak var firstLabel : UILabel!
    @IBOutlet weak var secondLabel : UILabel!
    
    static let identifier = "MainCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MainCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImage.layer.cornerRadius = 10
        posterImage.clipsToBounds = true
        firstLabel.clipsToBounds = true
        secondLabel.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        posterImage.image = nil
        firstLabel.text = ""
        secondLabel.text = ""
    }
    // manages data coming from table view cell
    func configure(_ data: MovieData?){
        if let posterPath = data?.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath){
            posterImage.downloadedFrom(url: url)
        }
        firstLabel.text = data?.title
        secondLabel.text = data?.release_date
    }
}
