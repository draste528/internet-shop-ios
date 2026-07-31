//
//  CartView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct CartView: View {

    // MARK: - Properties
    @StateObject private var viewModel = CartViewModel()

    // MARK: - Body
    var body: some View {
        Text(viewModel.title)
    }
}

#Preview {
    CartView()
}
