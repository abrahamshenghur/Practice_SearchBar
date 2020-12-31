//
//  ViewController.swift
//  Practice_SearchBar
//
//  Created by Abraham on 12/20/20.
//  Copyright © 2020 Abraham Shenghur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)                     // 2
    
    var movies: [Movie] = []                                                                    // 1
    var filteredMovies: [Movie] = []                                                            // 5
    
    var isSearchBarEmpty: Bool {                                                                // 6
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {                                                                     // 8
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0                    // 17
        
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)                        // 18
    }
    
    
    struct Cells {
        static let movieCell = "movieCel"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        movies = fetchMovies()
        configureTableView()
        configureSearchController()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    func fetchMovies() -> [Movie] {
        if let url = Bundle.main.url(forResource: "movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode([Movie].self, from: data)
                for movie in response {
                    movies.append(movie)
                }
                return movies
            } catch {
                print("Some error: \(error)")
            }
        }
        
        return []
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: Cells.movieCell)
        tableView.pin(to: view)
    }
    
    
    func configureSearchController() {                                                          // 4
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a movie"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = Movie.Genre.allCases.map { $0.rawValue }                     // 21
        searchController.searchBar.delegate = self                                                                  // 22
    }
    
   
    func filterContentForSearchText(_ searchText: String, genre: Movie.Genre? = nil) {          // 7
        filteredMovies = movies.filter { (movie) -> Bool in
            let doesGenreMatch = genre == .all || movie.genre == genre                                              // 15
            
            if isSearchBarEmpty {                                                                                   // 16
                return doesGenreMatch
            } else {
                return doesGenreMatch && movie.title.lowercased().contains(searchText.lowercased())
            }
        }

        tableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {                                                                                            // 10
            return filteredMovies.count
        }
        
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell, for: indexPath) as! MovieCell
        let movie: Movie                                                                                            // 11
        
        if isFiltering {                                                                                            // 12
            movie = filteredMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }

        cell.titleLabel.text = movie.title
        cell.genreLabel.text = movie.genre.rawValue
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = DetailViewController()                                                                         // 13
        
        if isFiltering {
            destVC.imageName = filteredMovies[indexPath.row]
        } else {
            destVC.imageName = movies[indexPath.row]
        }
        
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}


extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {                        // 3
        let searchBar = searchController.searchBar
        let scopeGenre = Movie.Genre(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])    // 19
        filterContentForSearchText(searchBar.text!, genre: scopeGenre)                          // 9                // 20
    }
}


extension ViewController: UISearchBarDelegate {                                                                     // 14
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let scopeGenre = Movie.Genre(rawValue: searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, genre: scopeGenre)
    }
}

