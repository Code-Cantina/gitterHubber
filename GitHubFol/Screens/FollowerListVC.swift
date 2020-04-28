//
//  FollowerListVC.swift
//  GitHubFol
//
//  Created by Danny Copeland on 1/28/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//


import UIKit

class FollowerListVC: UIViewController {

    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(userName: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
 
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func getFollowers(userName: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
          
            guard let self = self else { return } //unwrap the optional
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                //after appending the folowers check if the followers is empty
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers, go follow them 😃."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    func updateData() {
        var snapshop = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshop.appendSections([.main])
        snapshop.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshop, animatingDifferences: true)
        }
    }

}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y //will change as scroll
        let contentHeight = scrollView.contentSize.height //the entire scrollview, all followers, will be same as scroll
        let height = scrollView.frame.size.height //device height, will be same as scroll
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(userName: username, page: page)
        }
        
    }
    
}

