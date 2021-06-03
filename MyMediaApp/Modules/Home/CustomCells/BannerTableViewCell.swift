//
//  BannerTableViewCell.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit

protocol BannerTableCellProtocol: AnyObject where Self: UITableViewDelegate {
    func bannerTapped(sectionIndex: Int, itemIndex: Int)
}
// it is used for making TOP banner screen in displaying most recent pictures
class BannerTableViewCell: UITableViewCell {


    @IBOutlet weak var customBannerCollectionView: UICollectionView!
    
    var movieData: [MovieData]?
    weak var delegate: BannerTableCellProtocol?
    var cellIndex: Int = 0
    static let identifier = "BannerTableViewCell"
    
    static func nib() -> UINib {
       return UINib(nibName: "BannerTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        customBannerCollectionView.register(BannerCollectionViewCell.nib(), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)

         startTimer()

        customBannerCollectionView.delegate = self
        customBannerCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ data: HomeData){
        movieData = data.movieData
        customBannerCollectionView.reloadData()
    }
    
    func startTimer() {
        
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        for cell in customBannerCollectionView.visibleCells {
            let indexPath: IndexPath = customBannerCollectionView.indexPath(for: cell)!
            if (indexPath.row < (movieData?.count ?? 0) - 1){
                let indexPath1 = IndexPath.init(row: indexPath.row + 1, section: indexPath.section)
                customBannerCollectionView.scrollToItem(at: indexPath1, at: .left, animated: true)
            } else {
                self.customBannerCollectionView.setContentOffset(.zero, animated: true)
            }
            
        }
    }
}

extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customBannerCollectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
        cell.configure(movieData?[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = customBannerCollectionView.frame.width - 50
        return CGSize(width: width, height: width*(9/16))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.bannerTapped(sectionIndex: cellIndex, itemIndex: indexPath.row)
    }
    
}
