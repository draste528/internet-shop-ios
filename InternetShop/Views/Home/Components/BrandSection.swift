//
//  BrandSection.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct BrandSection: View {

    // MARK: - Body

    var body: some View {

        VStack(spacing: 8) {

            Image("LOGO")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)


            Text("MINIMALIST")
                .font(.system(size: 20, weight: .bold))
                .tracking(4)
                .foregroundStyle(Color.black)


            Text("furniture store")
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color.black)
        }
    }
}


#Preview {
    BrandSection()
}
