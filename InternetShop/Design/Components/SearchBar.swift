//
//  SearchBar.swift
//  InternetShop
//
//  Created by kair on 14.08.26.
//


import SwiftUI

struct SearchBar: View {
    var placeholder: String = "Search"

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.appGray)
            Text(placeholder)
                .font(.appInput)
                .foregroundStyle(Color.appGray)
            Spacer()
        }
        .padding(.horizontal, 12)
        .frame(height: 44)
        .background(Color.appDisabled)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
