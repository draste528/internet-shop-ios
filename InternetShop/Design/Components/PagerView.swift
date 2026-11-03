//
//  PagerView.swift
//  InternetShop
//
//  Created by kair on 24.10.26.
//

import SwiftUI

/// Generic horizontal pager built on a paging `ScrollView`: shows one page at a time.
/// Pages are switched by swipe, by optional left/right arrow buttons, or both; the dot indicator is optional.
struct PagerView<Item, Page: View>: View {
    private let items: [Item]
    private let externalSelection: Binding<Int>?
    private let showsArrows: Bool
    private let showsIndicator: Bool
    private let isSwipeEnabled: Bool
    private let pageHeight: CGFloat?
    private let page: (Item) -> Page

    private let arrowSpacing: CGFloat = 8
    private let indicatorSpacing: CGFloat = 12

    /// Used when the caller does not need to own the selected index.
    @State private var internalSelection = 0

    /// - Parameters:
    ///   - selection: pass a binding to control the index from outside, or nil to let the pager own it.
    ///   - showsArrows: adds left/right buttons around the pages.
    ///   - showsIndicator: adds the dot indicator below the pages.
    ///   - isSwipeEnabled: set to false to switch pages only with the arrows.
    ///   - pageHeight: fixed page height; nil lets the pager take the height of its tallest page.
    init(
        _ items: [Item],
        selection: Binding<Int>? = nil,
        showsArrows: Bool = false,
        showsIndicator: Bool = false,
        isSwipeEnabled: Bool = true,
        pageHeight: CGFloat? = nil,
        @ViewBuilder page: @escaping (Item) -> Page
    ) {
        self.items = items
        self.externalSelection = selection
        self.showsArrows = showsArrows
        self.showsIndicator = showsIndicator
        self.isSwipeEnabled = isSwipeEnabled
        self.pageHeight = pageHeight
        self.page = page
    }

    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            VStack(spacing: indicatorSpacing) {
                HStack(spacing: arrowSpacing) {
                    if showsArrows {
                        arrowButton("chevron.left", isEnabled: canShowPrevious) {
                            showPage(currentIndex - 1)
                        }
                    }
                    pagesView
                        .frame(height: pageHeight)
                    if showsArrows {
                        arrowButton("chevron.right", isEnabled: canShowNext) {
                            showPage(currentIndex + 1)
                        }
                    }
                }
                if showsIndicator {
                    PageIndicatorView(count: items.count, selectedIndex: currentIndex)
                }
            }
        }
    }

    // MARK: - Selection

    private var selection: Binding<Int> {
        externalSelection ?? $internalSelection
    }

    /// Selected index clamped to the valid range (never negative), so a stale index never crashes.
    private var currentIndex: Int {
        items.clampedIndex(selection.wrappedValue)
    }

    /// Bridges the Int selection to the optional id that `scrollPosition(id:)` works with.
    private var scrollPosition: Binding<Int?> {
        Binding(
            get: { currentIndex },
            set: { newValue in
                if let newValue {
                    selection.wrappedValue = newValue
                }
            }
        )
    }

    private var canShowPrevious: Bool { currentIndex > 0 }
    private var canShowNext: Bool { currentIndex < items.count - 1 }

    private func showPage(_ index: Int) {
        withAnimation(.easeInOut) {
            selection.wrappedValue = items.clampedIndex(index)
        }
    }

    // MARK: - Pages

    /// One paging ScrollView serves every mode: swipe, arrows and the indicator all drive the same position.
    private var pagesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    page(items[index])
                        .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: scrollPosition, anchor: .center)
        .scrollDisabled(!isSwipeEnabled)
    }

    private func arrowButton(_ systemName: String, isEnabled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.appHeadline)
                .foregroundStyle(isEnabled ? Color.appPrimary : Color.appLightGray)
        }
        .disabled(!isEnabled)
    }
}

/// Dot indicator for paged content.
struct PageIndicatorView: View {
    let count: Int
    let selectedIndex: Int
    var dotSize: CGFloat = 10
    var spacing: CGFloat = 12
    var activeColor: Color = .appPrimary
    var inactiveColor: Color = .appLightGray

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<count, id: \.self) { index in
                Circle()
                    .fill(index == selectedIndex ? activeColor : inactiveColor)
                    .frame(width: dotSize, height: dotSize)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
