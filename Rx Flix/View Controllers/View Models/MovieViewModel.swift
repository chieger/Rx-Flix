//
//  MovieViewModel.swift
//  
//
//  Created by Charles Hieger on 3/31/19.
//

import Foundation

protocol MovieCellRepresentable {
   var title: String { get }
   var overview: String { get }
   var releaseDate: String? { get }
   var posterImageURL: URL? { get }
}

struct MovieViewModel {

   // MARK: - Properties

   let movie: Movie

   private let dateFormatterISO = ISO8601DateFormatter()
   private let dateFormatter = DateFormatter()

   var title: String {
      return movie.title
   }

   var overview: String {
      return movie.overview
   }

   var releaseDate: String? {
      guard let inputDateString = movie.releaseDate else { return nil }
      guard let date = dateFormatterISO.date(from: inputDateString) else { return nil }

      dateFormatter.dateFormat = "MMM dd"
      let outputDateString = dateFormatter.string(from: date)
      return outputDateString
   }

   var posterImageURL: URL? {
      guard let posterPath = movie.posterPath, let url = URL(string: API.BaseURLImageString + posterPath) else { return nil }
         return url  
   }

   var backdropImageURL: URL? {
      guard let backdropPath = movie.backdropPath, let url = URL(string: API.BaseURLImageString + backdropPath) else { return nil }
      return url
   }
}

extension MovieViewModel: MovieCellRepresentable { }
