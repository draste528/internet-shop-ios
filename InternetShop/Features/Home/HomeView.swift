//
//  HomeView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    let onStart: () -> Void

    var body: some View {
        VStack {
            Spacer()
            LogoSection()
            Spacer()
            PrimaryButton(title: "START SHOP") {
                viewModel.startShopping()
                onStart()
            }
            .frame(width: 218, height: 56)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.appWhite)
    }
}

#Preview {
    HomeView(onStart: {})
}
