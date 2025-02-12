//
//  CoinDataService.swift
//  Networking
//
//  Created by Dmitry Mkrtumyan on 11.02.25.
//

import Foundation


final class CoinDataService {
    
    
    let cURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=3&page=1&sparkline=false&price_change_percentage=24h&locale=en"
    
//    func
    
    func fetchCoinsList(_ completion: @escaping (Result<[CoinModel], CoinAPIError>) -> Void) {
        
        guard let url = URL(string: cURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(.requestFailed(description: error.localizedDescription)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "No HTTP Response")))
                return
            }
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            guard let data = data else { return }
            
            do {
                let coinsList = try JSONDecoder().decode([CoinModel].self, from: data)
                print(coinsList)
                completion(.success(coinsList))
            } catch {
                completion(.failure(.jsonParsingFailure))
            }
        }.resume()
    }
    
    func fetchCoin(coin: String,  completion: @escaping (Double) -> Void) {
        
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
