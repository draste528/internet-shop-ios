//
//  CartView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()
    var body: some View {
        NavigationStack {
            VStack { }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.appWhite)
                .navigationTitle(viewModel.title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
