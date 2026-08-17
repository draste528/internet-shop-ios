//
//  ScreenHeader.swift
//  InternetShop
//
//  Created by kair on 14.08.26.
//


import SwiftUI

struct ScreenHeader: View {
    let title: String

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.appHeadline)
                .foregroundStyle(Color.appBlack)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
            Rectangle()
                .fill(Color.appLightGray)
                .frame(height: 1)
        }
    }
}