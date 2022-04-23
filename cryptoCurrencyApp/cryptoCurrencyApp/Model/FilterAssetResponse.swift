//
//  FilterAssetResponse.swift
//  cryptoCurrencyApp
//
//  Created by Kwangjun Kim on 2022/04/22.
//

import Foundation

struct FilterAssetResponse: Codable {
    let assetId: String
    let name: String
    let typeIsCrypto: Int
    let dataStart: String
    let dataEnd: String
    let dataQuoteStart: String
    let dataQuoteEnd: String
    let dataOrderbookStart: String
    let dataOrderbookEnd: String
    let dataTradeStart: String
    let dataTradeEnd: String
    let dataSymbolsCount: Int
    let volumeOneHrsUSD: Double
    let volumeOneDayUSD: Double
    let volumeOneMthUSD: Double
    let priceUSD: Double
    
    enum CodingKeys: String, CodingKey {
        case assetId = "asset_id"
        case name
        case typeIsCrypto = "type_is_crypto"
        case dataStart = "data_start"
        case dataEnd = "data_end"
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderbookStart = "data_orderbook_start"
        case dataOrderbookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case dataSymbolsCount = "data_symbols_count"
        case volumeOneHrsUSD = "volume_1hrs_usd"
        case volumeOneDayUSD = "volume_1day_usd"
        case volumeOneMthUSD = "volume_1mth_usd"
        case priceUSD = "price_usd"
    }
}
