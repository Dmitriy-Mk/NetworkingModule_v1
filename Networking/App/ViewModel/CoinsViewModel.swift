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
    @Published var coinsList: [CoinModel] = []
    
    private let coinDataService = CoinDataService()
    
    init() {
        fetchCoins()
    }
    
    func fetchCoins() {
        coinDataService.fetchCoinsList { [ weak self ] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                self.coinsList = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
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
