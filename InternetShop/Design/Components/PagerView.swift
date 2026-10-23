//
//  PagerView.swift
//  InternetShop
//
//  Created by kair on 24.10.26.
//

import SwiftUI

/// Generic horizontal pager: shows one page at a time.
/// Pages are switched either by swipe or by left/right arrow buttons; the dot indicator is optional.
struct PagerView<Item, Page: View>: View {
    enum NavigationStyle {
        case swipe
        case arrows
    }

    private let items: [Item]
    private let externalSelection: Binding<Int>?
    private let navigationStyle: NavigationStyle
    private let showsIndicator: Bool
    private let pageHeight: CGFloat?
    private let page: (Item) -> Page

    /// Used when the caller does not need to own the selected index.
    @State private var internalSelection = 0

    /// - Parameters:
    ///   - selection: pass a binding to control the index from outside, or nil to let the pager own it.
    ///   - pageHeight: required for `.swipe` inside a ScrollView (TabView has no intrinsic height).
    init(
        _ items: [Item],
        selection: Binding<Int>? = nil,
        navigationStyle: NavigationStyle = .swipe,
        showsIndicator: Bool = false,
        pageHeight: CGFloat? = nil,
        @ViewBuilder page: @escaping (Item) -> Page
    ) {
        self.items = items
        self.externalSelection = selection
        self.navigationStyle = navigationStyle
        self.showsIndicator = showsIndicator
        self.pageHeight = pageHeight
        self.page = page
    }

    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            VStack(spacing: 12) {
                pagesView
                    .frame(height: pageHeight)
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

    /// Selected index clamped to the valid range, so a stale index never crashes.
    private var currentIndex: Int {
        min(max(selection.wrappedValue, 0), items.count - 1)
    }

    private var canShowPrevious: Bool { currentIndex > 0 }
    private var canShowNext: Bool { currentIndex < items.count - 1 }

    // MARK: - Pages

    @ViewBuilder
    private var pagesView: some View {
        switch navigationStyle {
        case .swipe:
            swipePagesView
        case .arrows:
            arrowPagesView
        }
    }

    private var swipePagesView: some View {
        TabView(selection: selection) {
            ForEach(items.indices, id: \.self) { index in
                page(items[index]).tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    private var arrowPagesView: some View {
        HStack(spacing: 8) {
            arrowButton("chevron.left", isEnabled: canShowPrevious) {
                selection.wrappedValue = currentIndex - 1
            }
            page(items[currentIndex])
                .frame(maxWidth: .infinity)
                // Recreate the page on change so child views with @StateObject (e.g. StarsView) refresh.
                .id(currentIndex)
            arrowButton("chevron.right", isEnabled: canShowNext) {
                selection.wrappedValue = currentIndex + 1
            }
        }
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
