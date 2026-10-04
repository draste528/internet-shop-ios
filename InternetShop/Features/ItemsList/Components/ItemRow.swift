//
//  ItemRow.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//

import SwiftUI

struct ItemRow: View {
    @StateObject private var viewModel: ItemRowViewModel

    init(item: Item) {
        _viewModel = StateObject(wrappedValue: ItemRowViewModel(item: item))
    }

    var body: some View {
        HStack(spacing: 16) {
            imageView
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.item.name)
                    .font(.appHeadline)
                    .foregroundStyle(Color.appBlack)
                
                StarsView(viewModel: StarsViewModel(rating: Double(viewModel.item.rating)))
                
                Text(viewModel.priceFormatted)
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
        if let url = viewModel.imageURL {
            AsyncImage(url: url) { phase in
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
        } else {
            fallbackImage
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
