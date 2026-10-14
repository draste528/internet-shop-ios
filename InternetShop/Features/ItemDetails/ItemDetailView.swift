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

    init(itemId: UUID) {
        _viewModel = StateObject(wrappedValue: ItemDetailViewModel(itemId: itemId))
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appWhite)
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton { dismiss() }
                }
            }
            .task { await viewModel.loadDetails() }
    }

    @ViewBuilder
    private var content: some View {
        if let details = viewModel.details {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    gallery
                    info(details)
                    Rectangle()
                        .fill(Color.appLightGray)
                        .frame(height: 1)
                        .padding(.horizontal, horizontalPadding)
                    reviewsSection
                    PrimaryButton(title: "BUY") { viewModel.buy() }
                        .padding(.horizontal, horizontalPadding)
                }
                .padding(.vertical, 16)
            }
        } else if let message = viewModel.errorMessage {
            Text(message)
                .font(.appBody)
                .foregroundStyle(Color.appGray)
        } else {
            ProgressView()
        }
    }

    // MARK: - Gallery

    private var gallery: some View {
        let urls = viewModel.imageURLs
        return VStack(spacing: 12) {
            TabView(selection: $viewModel.selectedImageIndex) {
                if urls.isEmpty {
                    fallbackImage.tag(0)
                } else {
                    ForEach(Array(urls.enumerated()), id: \.offset) { index, url in
                        remoteImage(url).tag(index)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 245)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, horizontalPadding)

            HStack(spacing: 12) {
                ForEach(0..<max(urls.count, 1), id: \.self) { index in
                    Circle()
                        .fill(index == viewModel.selectedImageIndex ? Color.appPrimary : Color.appLightGray)
                        .frame(width: 10, height: 10)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    @ViewBuilder
    private func remoteImage(_ url: URL?) -> some View {
        if let url {
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
                .frame(width: 60, height: 60)
                .foregroundStyle(Color.appLightGray)
        }
    }

    // MARK: - Info

    private func info(_ details: ItemDetails) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 20) {
                Text(details.name)
                    .font(.appName)
                    .foregroundStyle(Color.appBlack)
                Spacer()
                actionIcon("heart.fill", isActive: viewModel.isFavorited, action: viewModel.toggleFavorite)
                actionIcon("basket.fill", isActive: viewModel.isAddedToCart, action: viewModel.toggleCart)
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

    private func actionIcon(_ systemName: String, isActive: Bool, action: @escaping () -> Void) -> some View {
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
    private var reviewsSection: some View {
        if let review = viewModel.currentReview {
            HStack(spacing: 8) {
                arrow("chevron.left", isEnabled: viewModel.canShowPreviousReview, action: viewModel.showPreviousReview)
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
                .frame(maxWidth: .infinity)
                // StarsView keeps its first ViewModel, so recreate it when the review changes.
                .id(review.id)
                arrow("chevron.right", isEnabled: viewModel.canShowNextReview, action: viewModel.showNextReview)
            }
            .padding(.horizontal, horizontalPadding)
        }
    }

    private func arrow(_ systemName: String, isEnabled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.appHeadline)
                .foregroundStyle(isEnabled ? Color.appPrimary : Color.appLightGray)
        }
        .disabled(!isEnabled)
    }
}
