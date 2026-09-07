//
//  ItemRow.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//


import SwiftUI

struct ItemRow: View {
    let item: Item

    var body: some View {
        HStack(spacing: 16) {
            imageView
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 6) {
                Text(item.name)
                    .font(.appHeadline)
                    .foregroundStyle(Color.appBlack)
                
                StarsView(rating: Double(item.rating))
                
                Text("$\(item.priceValue, specifier: "%.2f")")
                    .font(.appBodySemibold)
                    .foregroundStyle(Color.appPrimary)
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.appWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.appLightGray, lineWidth: 1)
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        let urlString = item.thumbnailURL ?? ""
        
        if urlString.isEmpty || !urlString.hasPrefix("http") {
            fallbackImage
        } else {
            AsyncImage(url: URL(string: urlString)) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Rectangle().fill(Color.appDisabled)
                        ProgressView()
                    }
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure:
                    fallbackImage
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
    
    private var fallbackImage: some View {
        ZStack {
            Rectangle().fill(Color.appDisabled)
            Image("LOGO")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundStyle(Color.appGray)
                .opacity(0.4)
        }
    }
}
