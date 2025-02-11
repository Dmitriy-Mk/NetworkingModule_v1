//
//  CoinsViewModel.swift
//  NetworkingMasterclass
//
//  Created by Dmitry Mkrtumyan on 11.02.25.
//

import Foundation


class CoinsViewModel: ObservableObject {
    
    
    @Published var coin = ""
    @Published var price = ""
    @Published var errorMessage = ""
    
    init() {
        fetchCoins(coin: "Bitcoin")
    }
    
    func fetchCoins(coin: String) {
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                print("Error: \(error.localizedDescription)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self.errorMessage = "DEBUG: Bad HTTP response"
                print("DEBUG: Bad HTTP response")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                return
            }
            
            guard let data = data,
                  let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            else {
                print("Error: \(error?.localizedDescription ?? "Default")")
                return
            }
            
            guard let value = jsonObject["bitcoin"] as? [String: Int] else { return }
            let price = value["usd"] ?? 0
            
            DispatchQueue.main.async {
                self.coin = "Bitcoin"
                self.price = "$\(price)"
            }
            
            print(price as Any)
        }.resume()
    }
}
