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

   var movieViewModels = [MovieViewModel]() {
      didSet {
         updateView()
      }
   }

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

   private func updateView() {
      movieTableView.reloadData()
   }

   // MARK: - Helper Methods
   private func fetchMoviesNowPlaying() {
      apiManager.fetchMoviesNowPlaying { (movies, error) in
         if let error = error {
            print(error.localizedDescription)
            return
         } else if let movies = movies {
            // Create view models from model
            self.movieViewModels = movies.map({ (movie) -> MovieViewModel in
               return MovieViewModel(movie: movie)
            })
         }
      }
   }
}

extension MovieViewController: UITableViewDataSource {

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return movieViewModels.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else { fatalError("Unexpected Table View Cell")}
      let movieViewModel = movieViewModels[indexPath.row]
      cell.configure(withViewModel: movieViewModel)
      return cell
   }
}

