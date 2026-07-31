//
//  LogoSection.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct LogoSection: View {

    // MARK: - Body
    var body: some View {

        VStack(spacing: 8) {

            Image("LOGO")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)

            Text("MINIMALIST")
                .font(.appName)
                .tracking(4)
                .foregroundStyle(Color.appBlack)

            Text("furniture store")
                .font(.appBody)
                .foregroundStyle(Color.appBlack)
        }
    }
}


#Preview {
    LogoSection()
}
