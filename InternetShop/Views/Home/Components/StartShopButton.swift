//
//  StartShopButton.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct StartShopButton: View {

    // MARK: - Properties
    let action: () -> Void

    // MARK: - Body
    var body: some View {

        Button(action: action) {
            Text("START SHOP")
                .font(.appBodySemibold)
                .foregroundStyle(Color.appWhite)

        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(Color.appPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
    }
}

#Preview {
    StartShopButton {}
        .padding()
}
