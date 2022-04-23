//
//  SearchViewController.swift
//  cryptoCurrencyApp
//
//  Created by Kwangjun Kim on 2022/04/23.
//

import Foundation
import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultViewControllerDidSelect(searchResult: SearchResult)
}

class SearchResultViewController: UIViewController {
    private var searchResult: [SearchResult] = []
    
    weak var delegate: SearchResultViewControllerDelegate?
    
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)

//        tableView.isHidden = true
        return tableView
    }()
    
    
    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupTableViewLayout()
        setupTableView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
}

// MARK: - Public
extension SearchResultViewController {
    public func update(with searchResult: SearchResult) {
        self.searchResult.append(searchResult)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.isHidden = self.searchResult.isEmpty
            self.tableView.reloadData()
        }
    }
}

// MARK: - Private
private extension SearchResultViewController {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTableViewLayout() {
        self.view.addSubview(tableView)
    }
}

// MARK: - extension UITableViewDelegate, UITableViewDataSource
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else { fatalError() }
        
        let model = searchResult[indexPath.row]
        
        if #available(iOS 14.0, *) {
            var contentConfigure = cell.defaultContentConfiguration()
            
            contentConfigure.text = model.assetId
            contentConfigure.secondaryText = model.name
            
            cell.contentConfiguration = contentConfigure
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = model.assetId
            cell.detailTextLabel?.text = model.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = searchResult[indexPath.row]
        
        delegate?.searchResultViewControllerDidSelect(searchResult: model)
    }
}
