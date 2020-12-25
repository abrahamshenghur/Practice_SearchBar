//
//  DetailViewController.swift
//  Practice_SearchBar
//
//  Created by Abraham on 12/24/20.
//  Copyright © 2020 Abraham Shenghur. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageName: Movie?
    var posterImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePosterImageView()
    }
    
    
    func configurePosterImageView() {
        view.addSubview(posterImageView)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        
        if let imageName = imageName {
            posterImageView.image = UIImage(named: (imageName.posterImage))
        }
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
