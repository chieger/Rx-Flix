//
//  MovieViewController.swift
//  Rx Flix
//
//  Created by Charles Hieger on 3/30/19.
//  Copyright © 2019 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieViewController: UIViewController {

   // MARK: - Properties

   @IBOutlet weak var movieTableView: UITableView!

   var movies = [Movie]()

   private lazy var apiManager = {
      return APIManager(baseURL: API.AuthenticatedBaseURL)
   }()

   // MARK: - View Life Cycle

   override func viewDidLoad() {
      super.viewDidLoad()
      setupView()
      fetchMoviesNowPlaying()
   }

   // MARK: -
   private func setupView() {
      movieTableView.dataSource = self
      movieTableView.rowHeight = 200
   }

   // MARK: - Helper Methods
   private func fetchMoviesNowPlaying() {
      apiManager.fetchMoviesNowPlaying { (movies, error) in
         if let error = error {
            print(error.localizedDescription)
            return
         } else if let movies = movies {
            print("Movies fetched 👍")
            self.movies = movies
            self.movieTableView.reloadData()
         }
      }
   }
}

extension MovieViewController: UITableViewDataSource {

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      print("number of rows called with count \(movies.count)")
      return movies.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else { fatalError("Unexpected Table View Cell")}
      let movie = movies[indexPath.row]
      cell.titleLabel.text = movie.title
      cell.releaseDateLabel.text = movie.releaseDate
      cell.overviewLabel.text = movie.overview
      if let posterPath = movie.posterPath, let url = URL(string: API.BaseURLImageString + posterPath) {
         cell.posterImageView.af_setImage(withURL: url)
      }
      return cell
   }
}

