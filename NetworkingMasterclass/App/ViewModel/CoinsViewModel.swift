//
//  CoinsViewModel.swift
//  NetworkingMasterclass
//
//  Created by Dmitry Mkrtumyan on 11.02.25.
//

import Foundation


class CoinsViewModel: ObservableObject {
    

    @Published var coins = ""
    @Published var price = ""
    
    init() {
        fetchCoins()
    }
    
    func fetchCoins() {
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                  let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            else {
                print("Error: \(error?.localizedDescription ?? "Default")")
                return
            }
            
            let value = jsonObject["bitcoin"] as? [String: Int]
            
            print(value as Any)
        }.resume()
    }
    
}
