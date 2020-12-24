//
//  MovieCell.swift
//  Practice_SearchBar
//
//  Created by Abraham on 12/20/20.
//  Copyright © 2020 Abraham Shenghur. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var genreLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(genreLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: genreLabel.leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            genreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: centerXAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            genreLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
