//
//  CoinDataService.swift
//  Networking
//
//  Created by Dmitry Mkrtumyan on 11.02.25.
//

import Foundation

final class CoinDataService {
    
    func fetchCoins(coin: String,  completion: @escaping (Double) -> Void) {
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
//                self.errorMessage = error.localizedDescription
                print("Error: \(error.localizedDescription)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
//                self.errorMessage = "DEBUG: Bad HTTP response"
                print("DEBUG: Bad HTTP response")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
//                self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                return
            }
            
            guard let data = data,
                  let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            else {
                print("Error: \(error?.localizedDescription ?? "Default")")
                return
            }
            
            guard let value = jsonObject[coin] as? [String: Double] else { return }
            let price = value["usd"] ?? 0.0
            
            completion(price)
        }.resume()
    }
}
