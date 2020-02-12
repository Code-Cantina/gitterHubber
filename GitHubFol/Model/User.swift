//
//  User.swift
//  GitHubFol
//
//  Created by Danny Copeland on 1/31/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String? //optional
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
