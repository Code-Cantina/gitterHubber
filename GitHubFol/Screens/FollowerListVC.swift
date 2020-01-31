//
//  FollowerListVC.swift
//  GitHubFol
//
//  Created by Danny Copeland on 1/28/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//


import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
 

}
