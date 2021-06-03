//
//  TableViewCell.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 28/04/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit

protocol CustomTableCellProtocol: AnyObject where Self: UITableViewDelegate {
    func cellTapped(sectionIndex: Int, itemIndex: Int)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewCellUILabel : UILabel!
    @IBOutlet weak var tableViewCellCollectionView : UICollectionView!
    
    weak var delegate: CustomTableCellProtocol?
    var cellIndex: Int = 0
    var movieData: [MovieData]?
    
    static let identifier = "TableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
        tableViewCellCollectionView.register(MainCollectionViewCell.nib(), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        tableViewCellCollectionView.layer.cornerRadius = 10
        tableViewCellCollectionView.layer.shadowColor = UIColor.gray.cgColor
        tableViewCellCollectionView.layer.shadowOpacity = 1
        tableViewCellCollectionView.layer.shadowOffset = .zero
        tableViewCellCollectionView.layer.shadowRadius = 10
        tableViewCellCollectionView.delegate = self
        tableViewCellCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ data: HomeData){
        tableViewCellUILabel.text = data.sectionTitle
        movieData = data.movieData
        tableViewCellCollectionView.reloadData()
        //buttonAction()
    }
//    func buttonAction() {
//        collectionViewHeightConstraint.constant = expandButton.isSelected ? 0 : 260
//        expandButton.isSelected = !expandButton.isSelected
//    }
    
}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tableViewCellCollectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.configure(movieData?[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellTapped(sectionIndex: cellIndex, itemIndex: indexPath.row)
    }
    
}
