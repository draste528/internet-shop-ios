//
//  StarsView.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//


import SwiftUI
import Combine

struct StarsView: View {
    @StateObject private var viewModel: StarsViewModel
    let spacing: CGFloat

    init(viewModel: StarsViewModel, spacing: CGFloat = 2) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.spacing = spacing
    }

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<viewModel.maxRating, id: \.self) { index in
                Image(systemName: viewModel.iconName(for: index))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(Color.appYellow)
            }
        }
    }
}
