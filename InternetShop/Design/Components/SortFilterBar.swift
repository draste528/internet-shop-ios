//
//  SortFilterBar.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import SwiftUI

struct SortFilterBar: View {
    var onSort: () -> Void = {}
    var onFilter: () -> Void = {}

    var body: some View {
        HStack {
            Button(action: onSort) {
                Image(systemName: "arrow.up.arrow.down")
                    .frame(maxWidth: .infinity)
            }
            Button(action: onFilter) {
                Image(systemName: "line.3.horizontal.decrease")
                    .frame(maxWidth: .infinity)
            }
        }
        .font(.system(size: 20))
        .foregroundStyle(Color.appBlack)
        .frame(height: 48)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.appLightGray).frame(height: 1)
        }
    }
}