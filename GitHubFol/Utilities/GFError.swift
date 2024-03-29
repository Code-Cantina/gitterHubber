//
//  GFError.swift
//  GitHubFol
//
//  Created by Danny Copeland on 5/4/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUserName = "This username created and invalid request. Please try again"
    case unableToComplete = "Unable to completed request, check interent connection? Turn it off and back on?? Haha!!"
    case invalidResponse = "Invalid response from server."
    case invalidData = "The data received from server is invalid"
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "This user already in favorites"
    
}
