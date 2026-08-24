//
//  ContentView.swift
//  InternetShop
//
//  Created by kair on 26.07.26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RootViewModel()

    var body: some View {
        switch viewModel.route {
        case .launch:
            LaunchView(viewModel: viewModel.launchViewModel, onContinue: viewModel.showMain)
        case .main:
            TabsView(catalogViewModel: viewModel.catalogViewModel)
        }
    }
}
