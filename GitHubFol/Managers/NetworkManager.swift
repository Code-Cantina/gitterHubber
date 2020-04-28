//
//  NetworkManager.swift
//  GitHubFol
//
//  Created by Danny Copeland on 1/31/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//

import UIKit

class NetworkManager { //singleton, 1 instance
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for userName: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        //"/users/:username/followers"
        let endpoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        print("url: \(endpoint)")
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        
        //paranthesis around variables returned are optional (data, response, error)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error { //if the error exists
                completed(.failure(.unableToComplete))
                return
            }
            
            //if the respons eis not nil, set it to response var.. check response status code for 200, else do the block
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //something other than 200.. or nil response?
                completed(.failure(.invalidResponse))
                return
            }
            
            //check the data if we make it here
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            //parse the data
            do {
                let decoder = JSONDecoder()
                //convert the snale case stuff to our camel casing values in codable class
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                
                completed(.success(followers))
                
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume() //start the network call
        
    }
    
}
