//
//  Movie.swift
//  Rx Flix
//
//  Created by Charles Hieger on 3/30/19.
//  Copyright © 2019 Charles Hieger. All rights reserved.
//

import Foundation

// Used to contain the initital dictionary returned from the MovieDB API
struct MovieWrapper: Codable {
   let results: [Movie]
}

struct Movie: Codable {

   // MARK: - Properties

   var title: String
   var overview: String
   var releaseDate: String?
   var posterPath: String?
   var backdropPath: String?

   enum CodingKeys: String, CodingKey {
      case title
      case overview
      case releaseDate = "release_date"
      case posterPath = "poster_path"
      case backdropPath = "backdrop_path"
   }
}
