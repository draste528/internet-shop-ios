//
//  CatalogView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct CatalogView: View {

    // MARK: - Properties
    @StateObject private var viewModel = CatalogViewModel()

    // MARK: - Body
    var body: some View {
        Text(viewModel.title)
    }
}

#Preview {
    CatalogView()
}
