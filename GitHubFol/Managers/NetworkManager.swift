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
    
    //@escaping. closure have to outlive the function for async calls. By Default closures are not escaping
    func getUserInfo(for userName: String, completed: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseUrl + "\(userName)"
        
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
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                
                completed(.success(user))
                
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume() //start the network call
        
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return //since we have the cached image return
        }
        
        //intentionally not handling errors for avatar images, since the place holder image will be used
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey) //set the image cache
            completed(image)
            
        }
        task.resume()
    }
    
}
