//
//  ItemDetailView.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//


import SwiftUI

struct ItemDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ItemDetailViewModel

    private let horizontalPadding: CGFloat = 20
    private let galleryHeight: CGFloat = 245
    private let cornerRadius: CGFloat = 12

    init(itemId: UUID) {
        _viewModel = StateObject(wrappedValue: ItemDetailViewModel(itemId: itemId))
    }

    var body: some View {
        contentView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appWhite)
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .appNavigationBar()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton { dismiss() }
                }
            }
            .task { await viewModel.loadDetails() }
    }

    // MARK: - Content

    /// Screen states: details loaded -> content, load failed -> error text, otherwise -> loader.
    /// The loader is the fallback branch so the first frame (before `.task` starts) is never empty.
    @ViewBuilder
    private var contentView: some View {
        if let details = viewModel.details {
            detailsScrollView(details)
        } else if let message = viewModel.errorMessage {
            Text(message)
                .font(.appBody)
                .foregroundStyle(Color.appGray)
        } else {
            ProgressView()
        }
    }

    private func detailsScrollView(_ details: ItemDetails) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                galleryView
                infoView(details)
                dividerView
                reviewsView
                PrimaryButton(title: "BUY") { viewModel.buy() }
                    .padding(.horizontal, horizontalPadding)
            }
            .padding(.vertical, 16)
        }
    }

    private var dividerView: some View {
        Rectangle()
            .fill(Color.appLightGray)
            .frame(height: 1)
            .padding(.horizontal, horizontalPadding)
    }

    // MARK: - Gallery

    @ViewBuilder
    private var galleryView: some View {
        if viewModel.imageURLs.isEmpty {
            fallbackImageView
                .frame(height: galleryHeight)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .padding(.horizontal, horizontalPadding)
        } else {
            PagerView(
                viewModel.imageURLs,
                selection: $viewModel.selectedImageIndex,
                navigationStyle: .swipe,
                showsIndicator: true,
                pageHeight: galleryHeight
            ) { url in
                remoteImageView(url)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .padding(.horizontal, horizontalPadding)
            }
        }
    }

    private func remoteImageView(_ url: URL) -> some View {
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
                fallbackImageView
            @unknown default:
                fallbackImageView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var fallbackImageView: some View {
        ZStack {
            Rectangle().fill(Color.appDisabled)
            Image("LOGO")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundStyle(Color.appLightGray)
        }
    }

    // MARK: - Info

    private func infoView(_ details: ItemDetails) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 20) {
                Text(details.name)
                    .font(.appName)
                    .foregroundStyle(Color.appBlack)
                Spacer()
                actionIconButton("heart.fill", isActive: viewModel.isFavorited, action: viewModel.toggleFavorite)
                actionIconButton("basket.fill", isActive: viewModel.isAddedToCart, action: viewModel.toggleCart)
            }
            Text(details.subCategory.name)
                .font(.appBody)
                .foregroundStyle(Color.appBlack)
            StarsView(
                viewModel: StarsViewModel(rating: Double(details.rating)),
                starSize: 24
            )
            Text(details.description)
                .font(.appBody)
                .foregroundStyle(Color.appBlack)
        }
        .padding(.horizontal, horizontalPadding)
    }

    private func actionIconButton(_ systemName: String, isActive: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(isActive ? Color.appPrimary : Color.appLightGray)
        }
    }

    // MARK: - Reviews

    @ViewBuilder
    private var reviewsView: some View {
        if !viewModel.reviews.isEmpty {
            PagerView(viewModel.reviews, navigationStyle: .arrows) { review in
                reviewView(review)
            }
            .padding(.horizontal, horizontalPadding)
        }
    }

    private func reviewView(_ review: Review) -> some View {
        VStack(spacing: 12) {
            StarsView(
                viewModel: StarsViewModel(rating: Double(review.rating)),
                starSize: 20
            )
            if let message = review.message {
                Text(message)
                    .font(.appBody)
                    .foregroundStyle(Color.appBlack)
                    .multilineTextAlignment(.center)
            }
            if let author = review.author {
                Text(author)
                    .font(.appBodySemibold)
                    .foregroundStyle(Color.appBlack)
            }
        }
    }
}
