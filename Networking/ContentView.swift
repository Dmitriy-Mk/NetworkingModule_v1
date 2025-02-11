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
            
            if viewModel.errorMessage.isEmpty {
                Text("\(viewModel.coin), \(viewModel.price)")
            } else {
                Text("\(viewModel.errorMessage)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
