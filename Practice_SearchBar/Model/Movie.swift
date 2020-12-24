//
//  Movie.swift
//  Practice_SearchBar
//
//  Created by Abraham on 12/20/20.
//  Copyright © 2020 Abraham Shenghur. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let genre: Genre
    
    enum Genre: Decodable {
        case all
        case action
        case comedy
        case horror
        case thriller
    }
}


extension Movie.Genre: RawRepresentable {
    typealias RawValue = String
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case "All":
            self = .all
        case "Action":
            self = .action
        case "Comedy":
            self = .comedy
        case "Horror":
            self = .horror
        case "Thriller":
            self = .thriller
        default:
            return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .all:
            return "All"
        case .action:
            return "Action"
        case .comedy:
            return "Comedy"
        case .horror:
            return "Horror"
        case .thriller:
            return "Thriller"
        }
    }
}
