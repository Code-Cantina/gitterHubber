//
//  GFButton.swift
//  GitHubFol
//
//  Created by Danny Copeland on 1/27/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//  https://github.com/aaronbrethorst/semanticui

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    required init?(coder: NSCoder) { //used by storyboard... so have to use it
        fatalError("init(coder:) has not been implemented")
    }
    
}
