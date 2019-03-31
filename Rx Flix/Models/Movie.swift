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
   var posterPath: String?
   var releaseDate: String?

   enum CodingKeys: String, CodingKey {
      case title
      case overview
      case posterPath = "poster_path"
      case releaseDate = "release_date"
   }
}
