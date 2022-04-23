//
//  SearchResultTableViewCell.swift
//  cryptoCurrencyApp
//
//  Created by Kwangjun Kim on 2022/04/23.
//

import Foundation
import UIKit

class SearchResultTableViewCell: UITableViewCell {
    static let identifier: String = "SearchResultTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
