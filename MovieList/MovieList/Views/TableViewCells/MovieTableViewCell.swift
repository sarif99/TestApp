//
//  MovieTableViewCell.swift
//  MovieList
//
//  Created by Shehroz Arif on 11/09/2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(with viewModel: MovieCellViewModel) {
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        
        if let posterURL = viewModel.posterURL {
            // Load the poster image using an image loading library (e.g., SDWebImage)            
            posterImageView.image = UIImage(named: "PlaceholderImage")
        } else {
            posterImageView.image = UIImage(named: "PlaceholderImage")
        }
    }
    
}
