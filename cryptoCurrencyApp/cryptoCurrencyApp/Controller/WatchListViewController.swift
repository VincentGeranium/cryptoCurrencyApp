//
//  WatchListViewController.swift
//  cryptoCurrencyApp
//
//  Created by Kwangjun Kim on 2022/04/22.
//

import Foundation
import UIKit

class WatchListViewController: UIViewController {
    
    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchViewController()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

// MARK: - Private
private extension WatchListViewController {
    private func setupSearchViewController() {
        let searchResultVC = SearchResultViewController()
        
        let searchController = UISearchController(searchResultsController: searchResultVC)
        searchController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchController
    }
}

extension WatchListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultVC = searchController.searchResultsController as? SearchResultViewController,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
    }

}
