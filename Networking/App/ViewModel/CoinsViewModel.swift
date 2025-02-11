//
//  CoinsViewModel.swift
//  NetworkingMasterclass
//
//  Created by Dmitry Mkrtumyan on 11.02.25.
//

import Foundation


final class CoinsViewModel: ObservableObject {
    
    
    @Published var coin = ""
    @Published var price = ""
    @Published var errorMessage: String?
    
    private let coinDataServiced = CoinDataService()
    
    init() {
        fetchCoins(coin: "bitcoin")
    }
    
    func fetchCoins(coin: String) {
        coinDataServiced.fetchCoins(coin: coin) { coinPrice in
            DispatchQueue.main.async {
                self.coin = coin
                self.price = "$\(coinPrice)"
            }
        }
    }
}
