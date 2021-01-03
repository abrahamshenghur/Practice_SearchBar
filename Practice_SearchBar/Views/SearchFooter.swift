//
//  SearchFooter.swift
//  Practice_SearchBar
//
//  Created by Abraham on 12/31/20.
//  Copyright © 2020 Abraham Shenghur. All rights reserved.
//

import UIKit

class SearchFooter: UIView {

    let label = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        label.frame = bounds
    }
    
    
    func setNotFiltering() {
        label.text = ""
        hideFooter()
    }
    
    
    func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
        if (filteredItemCount == totalItemCount) {
            setNotFiltering()
        } else if (filteredItemCount == 0) {
            label.text = "No items match your query"
            showFooter()
        } else {
            label.text = ("Filtering \(filteredItemCount) of \(totalItemCount)")
            showFooter()
        }
    }
    
    
    func hideFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 0.0
        }
    }
    
    
    func showFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 1.0
        }
    }

    
    func configureView() {
        backgroundColor = #colorLiteral(red: 0.01876508445, green: 0.4762849808, blue: 0.9986100793, alpha: 1)
        alpha           = 0.0
        translatesAutoresizingMaskIntoConstraints = false

        configureLabel()
    }
    
    
    func configureLabel() {
        label.textAlignment = .center
        label.textColor     = .white
        addSubview(label)
    }
}
