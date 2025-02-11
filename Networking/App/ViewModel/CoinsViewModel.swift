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
    
    private let coinDataService = CoinDataService()
    
    init() {
        fetchCoins()
    }
    
    func fetchCoins() {
        coinDataService.fetchCoinsList { result in
            print(result)
        }
    }
    
    func fetchCoins(coin: String) {
        coinDataService.fetchCoin(coin: coin) { coinPrice in
            DispatchQueue.main.async {
                self.coin = coin
                self.price = "$\(coinPrice)"
            }
        }
    }
}
