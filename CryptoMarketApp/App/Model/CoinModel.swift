//
//  CoinModel.swift
//  Networking
//
//  Created by Dmitry Mkrtumyan on 12.02.25.
//

import Foundation


struct CoinModel: Decodable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let currentPrice: Double
    let marketCapRank: Int
    
    enum CodingKeys: String,  CodingKey {
        case id, symbol, name
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
    }
}
