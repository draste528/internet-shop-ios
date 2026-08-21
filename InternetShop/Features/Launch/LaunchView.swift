//
//  LaunchView.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import SwiftUI

struct LaunchView: View {
    @ObservedObject var viewModel: LaunchViewModel
    let onContinue: () -> Void

    var body: some View {
        VStack {
            Spacer(); LogoSection(); Spacer()
            actionArea
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.appWhite)
        .task { await viewModel.runStartupJobs() }
    }

    @ViewBuilder
    private var actionArea: some View {
        ZStack {
            if viewModel.isReady {
                PrimaryButton(title: "START SHOP", action: onContinue)
                    .frame(width: 218, height: 56)
                    .transition(.opacity)
            } else {
                ProgressView()
            }
        }
        .frame(height: 56)
        .animation(.easeInOut(duration: 0.25), value: viewModel.isReady)
    }
}
