//
//  DetailScreenViewController.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit

class DetailScreenViewController: UIViewController {

    
    @IBOutlet weak var myMovieImage: UIImageView!
    @IBOutlet weak var myMovieTitle: UILabel!
    @IBOutlet weak var myVoteLabel: UILabel!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    @IBOutlet weak var movieVCLabel: UILabel!
    @IBOutlet weak var movieSummaryTextView: UITextView!
    
    var data : MovieData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myMovieTitle.text = data?.title
        myVoteLabel.text = String(data?.vote_average ?? 0)//"\((data?.vote_average) ?? 0)"
        movieVCLabel.text = "\((data?.vote_count) ?? 0)"
        movieLanguageLabel.text = data?.original_language
        movieSummaryTextView.text = data?.overview
        if let posterPath = data?.backdrop_path, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath){
            myMovieImage.downloadedFrom(url: url)
        }
    }
    

    

}
