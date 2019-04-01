//
//  MovieTableViewCell.swift
//  Rx Flix
//
//  Created by Charles Hieger on 3/31/19.
//  Copyright © 2019 Charles Hieger. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

   // MARK: - Type Properties

   static let reuseIdentifier = "MovieCell"

   // MARK: - Properties

   @IBOutlet weak var titleLabel: UILabel!
   @IBOutlet weak var releaseDateLabel: UILabel!
   @IBOutlet weak var overviewLabel: UILabel!
   @IBOutlet weak var posterImageView: UIImageView!


   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }

   func configure(withViewModel viewModel: MovieCellRepresentable) {
      titleLabel.text = viewModel.title
      releaseDateLabel.text = viewModel.releaseDate
      overviewLabel.text = viewModel.overview
      if let url = viewModel.posterImageURL {
         posterImageView.af_setImage(withURL: url)
      }
   }
}
