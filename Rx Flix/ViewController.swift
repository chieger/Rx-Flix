//
//  ViewController.swift
//  Rx Flix
//
//  Created by Charles Hieger on 3/30/19.
//  Copyright © 2019 Charles Hieger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   private lazy var apiManager = {
      return APIManager(baseURL: API.AuthenticatedBaseURL)
   }()

   // MARK: - View Life Cycle

   override func viewDidLoad() {
      super.viewDidLoad()
      fetchMoviesNowPlaying()
   }

   // MARK: - Helper Methods
   private func fetchMoviesNowPlaying() {
      apiManager.fetchMoviesNowPlaying { (movies, error) in
         if let error = error {
            print(error.localizedDescription)
            return
         }
         guard let movies = movies else {return}
         for movie in movies {
            print(movie.title)
         }
      }
   }
}

