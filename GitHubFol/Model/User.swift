//
//  User.swift
//  GitHubFol
//
//  Created by Danny Copeland on 1/31/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String? //optional
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
