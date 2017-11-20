//
//  MovieCollectionViewCell.swift
//  MoviesDemo
//
//  Created by Shrimant Nikate on 18/11/17.
//  Copyright © 2017 Shrimant Nikate. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImgPoster: UIImageView!
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var LblYear: UILabel!
    @IBOutlet weak var LblGenre: UILabel!
    @IBOutlet weak var LblRatings: UILabel!
    
    func SetupCellUI(movie:MovieModel)
    {
        LblTitle.text = movie.title ?? ""
        LblYear.text = "\(movie.releaseYear)"
        LblRatings.text = "\(movie.rating)"
        LblGenre.text = movie.getGenresInString()
        ImgPoster.sd_cancelCurrentImageLoad()

        if let imgURL = movie.imageUrl,
            let url = URL(string: imgURL){
            ImgPoster.sd_setImage(with: url, placeholderImage: UIImage(named: "photo"), options: .scaleDownLargeImages, progress: nil, completed: { (img, error, cache, url) in
            })
        }
    }
}
