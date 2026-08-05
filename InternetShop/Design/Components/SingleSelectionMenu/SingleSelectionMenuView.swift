//
//  SingleSelectionMenuView.swift
//  InternetShop
//
//  Created by kair on 04.08.26.
//

import SwiftUI

struct SingleSelectionMenuView: View {

    @ObservedObject var viewModel: SingleSelectionMenuViewModel
    var axis: Axis = .horizontal
    var spacing: CGFloat = 24

    var body: some View {
        let layout = axis == .horizontal
            ? AnyLayout(HStackLayout(spacing: 0))
            : AnyLayout(VStackLayout(spacing: spacing))

        layout {
            ForEach(viewModel.items, id: \.tag) { item in
                Button {
                    viewModel.select(item)
                } label: {
                    VStack(spacing: 4) {
                        Image(item.icon)
                            .renderingMode(.template)
                        Text(item.title)
                            .font(.appCaption)
                    }
                    .frame(maxWidth: axis == .horizontal ? .infinity : nil)
                    .foregroundStyle(viewModel.color(for: item))
                }
                .buttonStyle(.plain)
            }
        }
    }
}
