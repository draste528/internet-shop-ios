//
//  StarsView.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//


import SwiftUI

struct StarsView: View {
    let rating: Double
    var maxRating: Int = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxRating, id: \.self) { index in
                image(for: index)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(Color.appYellow)
            }
        }
    }

    private func image(for index: Int) -> Image {
        let starValue = rating - Double(index)
        if starValue >= 1 {
            return Image(systemName: "star.fill")
        } else if starValue >= 0.5 {
            return Image(systemName: "star.leadinghalf.filled")
        } else {
            return Image(systemName: "star")
        }
    }
}