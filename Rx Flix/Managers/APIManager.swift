//
//  DataManager.swift
//  Rx Flix
//
//  Created by Charles Hieger on 3/30/19.
//  Copyright © 2019 Charles Hieger. All rights reserved.
//

import Foundation

struct API {

   enum Endpoints {
      static let nowPlaying = "now_playing"
      static let latest = "latest"
      static let popular = "popular"
      static let top_rated = "top_rated"
      static let upcomming = "upcomming"
   }
   static let APIKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
   static let BaseURLString = "https://api.themoviedb.org/3/movie/"
   static let BaseURLImageString = "https://image.tmdb.org/t/p/w500/"

   static var AuthenticatedBaseURL: URL {
      return URL(string: BaseURLString+Endpoints.nowPlaying+"?api_key="+APIKey)!
   }
}

enum APIManagerError: Error {
   case unknown
   case failedRequest
   case invalidResponse
}

final class APIManager {

   typealias MovieCompletion = ([Movie]?, Error?) -> ()

   // MARK: - Properties

   private let baseURL: URL

   init(baseURL: URL) {
      self.baseURL = baseURL
   }

   // MARK: - Requesting Data
   func fetchMoviesNowPlaying(completion: @escaping MovieCompletion) {
      URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
         DispatchQueue.main.async {
            if let error = error {
               completion(nil, error)
            } else if let data = data, let response = response as? HTTPURLResponse {
               if response.statusCode == 200 {
                  do {
                     let jsonDecoder = JSONDecoder()
                     let movieWrapper = try jsonDecoder.decode(MovieWrapper.self, from: data)
                     let movies = movieWrapper.results
                     completion(movies, nil)
                  } catch {
                     completion(nil, APIManagerError.invalidResponse)
                  }
               } else {
                  completion(nil, APIManagerError.failedRequest)
               }
            } else {
               completion(nil, APIManagerError.unknown)
            }
         }
      }.resume()
   }
}
