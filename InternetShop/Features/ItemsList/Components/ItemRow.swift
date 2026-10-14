//
//  ItemRow.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//

import SwiftUI

struct ItemRow: View {
    @StateObject private var viewModel: ItemRowViewModel

    private let imageSide: CGFloat = 120

    init(item: Item) {
        _viewModel = StateObject(wrappedValue: ItemRowViewModel(item: item))
    }

    var body: some View {
        HStack(spacing: 20) {
            imageView
                .frame(width: imageSide, height: imageSide)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.item.name)
                    .font(.appHeadline)
                    .foregroundStyle(Color.appBlack)

                StarsView(
                    viewModel: StarsViewModel(rating: Double(viewModel.item.rating)),
                    starSize: 20
                )

                Text(viewModel.priceFormatted)
                    .font(.appBodySemibold)
                    .foregroundStyle(Color.appPrimary)
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
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
                .frame(width: 40, height: 40)
                .foregroundStyle(Color.appLightGray)
        }
    }
}
