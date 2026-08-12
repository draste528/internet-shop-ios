//
//  CategoryCardView.swift
//  InternetShop
//
//  Created by kair on 07.08.26.
//

import SwiftUI

struct CategoryCardView: View {
    let viewModel: CategoryCardViewModel

    var body: some View {
        VStack(spacing: 12) {
            viewModel.icon
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .foregroundStyle(Color.appPrimary)

            Text(viewModel.title)
                .font(.appCardTitle)
                .foregroundStyle(Color.appBlack)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .background(Color.appWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.appLightGray, lineWidth: 1)
        }
    }
}
