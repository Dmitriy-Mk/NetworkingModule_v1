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
                Text("\(viewModel.coin), \(viewModel.price)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
