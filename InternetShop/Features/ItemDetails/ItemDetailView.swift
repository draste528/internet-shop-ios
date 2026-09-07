//
//  ItemDetailView.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//


import SwiftUI

struct ItemDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let itemId: UUID
    
    var body: some View {
        VStack {
            Text("Item ID:\n\(itemId)")
                .font(.appHeadline)
                .foregroundStyle(Color.appBlack)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appWhite)
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton { dismiss() }
            }
        }
    }
}