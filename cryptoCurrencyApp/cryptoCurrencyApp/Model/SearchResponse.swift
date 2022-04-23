//
//  SearchResponse.swift
//  cryptoCurrencyApp
//
//  Created by Kwangjun Kim on 2022/04/23.
//

import Foundation
import UIKit

struct SearchResponse: Codable {
    let result: [SearchResult]
}

struct SearchResult: Codable {
    let assetId: String
    let name: String
    let typeIsCrypto: Int
    
    enum CodingKeys: String, CodingKey {
        case assetId = "asset_id"
        case name
        case typeIsCrypto = "type_is_crypto"
    }
}

