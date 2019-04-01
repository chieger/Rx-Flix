//
//  MovieViewController.swift
//  Rx Flix
//
//  Created by Charles Hieger on 3/30/19.
//  Copyright © 2019 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import RxSwift
import RxCocoa

class MovieViewController: UIViewController {

   // MARK: - Properties

   @IBOutlet weak var movieTableView: UITableView!

//   var movieViewModels = [MovieViewModel]()
//   var movieViewModelsRx: Observable<[MovieViewModel]>!

   //   var movieViewModels = [MovieViewModel]() {
   //      didSet {
   //         updateView()
   //      }
   //   }

   private let disposeBag = DisposeBag()

   private lazy var apiManager = {
      return APIManager(baseURL: API.AuthenticatedBaseURL)
   }()

   // MARK: - View Life Cycle

   override func viewDidLoad() {
      super.viewDidLoad()
//      movieViewModelsRx = Observable.just(movieViewModels)
//      movieViewModelsRx
//         .bind(to: self.movieTableView.rx.items(cellIdentifier: MovieTableViewCell.reuseIdentifier, cellType: MovieTableViewCell.self)) { (row, movieViewModel, cell) in
//            cell.configure(withViewModel: movieViewModel)
//         }
//         .disposed(by: self.disposeBag)

      setupView()
      fetchMoviesNowPlaying()
   }

   // MARK: -
   private func setupView() {
      // movieTableView.dataSource = self
      movieTableView.rowHeight = 200
   }

   // MARK: - Helper Methods
   private func fetchMoviesNowPlaying() {
      apiManager.fetchMoviesNowPlaying { (movies, error) in
         if let error = error {
            print(error.localizedDescription)
            return
         } else if let movies = movies {
            // Create view models from model
            let movieViewModels = movies.map({ (movie) -> MovieViewModel in
               return MovieViewModel(movie: movie)
            })
            // Create Rx view models
            let movieViewModelsRx = Observable.just(movieViewModels)
            // Bind Rx view model to table view
            movieViewModelsRx
               .bind(to: self.movieTableView.rx.items(cellIdentifier: MovieTableViewCell.reuseIdentifier, cellType: MovieTableViewCell.self)) { (row, movieViewModel, cell) in
                  cell.configure(withViewModel: movieViewModel)
               }
               .disposed(by: self.disposeBag)
         }
      }
   }
}

//extension MovieViewController: UITableViewDataSource {
//
//   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      return movieViewModels.count
//   }
//
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else { fatalError("Unexpected Table View Cell")}
//      let movieViewModel = movieViewModels[indexPath.row]
//      cell.configure(withViewModel: movieViewModel)
//      return cell
//   }
//}

