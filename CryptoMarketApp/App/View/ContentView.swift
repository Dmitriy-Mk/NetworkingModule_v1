//
//  ContentView.swift
//  NetworkingMasterclass
//
//  Created by Dmitry Mkrtumyan on 11.02.25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = CoinsViewModel()
    
    var body: some View {
        VStack {
            
            if let error = viewModel.errorMessage {
                Text("\(error)")
            } else {
                
                List {
                    ForEach(viewModel.coinsList) { coin in
                        HStack(spacing: 15) {
                            Text("\(coin.marketCapRank)")
                                .foregroundColor(.gray)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(coin.name)")
                                    .fontWeight(.semibold)
                                
                                Text("\(coin.symbol)")
                            }
                        }
                        .font(.footnote)
                    }
                }
                .background(Color.clear)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
