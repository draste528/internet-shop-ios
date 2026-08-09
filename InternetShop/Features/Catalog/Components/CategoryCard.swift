//
//  CategoryCard.swift
//  InternetShop
//
//  Created by kair on 07.08.26.
//

import SwiftUI

struct CategoryCard: View {
    let category: Category

    private var iconName: String {
        switch category.name.uppercased() {
        case "SOFAS":     return "couch"
        case "CHAIRS":    return "Chair"
        case "TABLES":    return "Table"
        case "LAMPS":     return "Lamp"
        case "BEDS":      return "Bed"
        case "WARDROBES": return "Wardrobe"
        default:          return "couch"
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            Image(iconName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .foregroundStyle(Color.appPrimary)

            Text(category.name.capitalized)
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
