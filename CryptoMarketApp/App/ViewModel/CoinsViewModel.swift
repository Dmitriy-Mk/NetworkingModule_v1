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
        Task {
            try await fetchAsyncCoinData()
        }
    }
    
    func fetchCoins() {
        coinDataService.fetchCoinsList { [ weak self ] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let success):
                    self.coinsList = success
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
    func fetchAsyncCoinData() async throws {
        coinsList = try await coinDataService.fetchCoinsList()
    }
}
