//
//  CoinModel.swift
//  Networking
//
//  Created by Dmitry Mkrtumyan on 12.02.25.
//

import Foundation


struct CoinModel: Decodable {
    let id: String
    let symbol: String
    let name: String
}
