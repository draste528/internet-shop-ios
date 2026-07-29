//
//  HomeView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Properties

    @Binding var showTabs: Bool


    // MARK: - Body

    var body: some View {

        VStack {

            Spacer()

            BrandSection()

            Spacer()

            StartShopButton {
                showTabs = true
            }
            .frame(width: 218, height: 56)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}


#Preview {
    HomeView(showTabs: .constant(false))
}
