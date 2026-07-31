//
//  HomeView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Properties
    @StateObject private var viewModel = HomeViewModel()

    // MARK: - Body
    var body: some View {
        if viewModel.showTabs {
            TabsView()
        } else {
            VStack {
                Spacer()
                LogoSection()
                Spacer()

                StartShopButton {
                    viewModel.startShopping()
                }
                .frame(width: 218, height: 56)

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.appWhite)
        }
    }
}

#Preview {
    HomeView()
}
