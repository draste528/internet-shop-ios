//
//  LaunchViewModel.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import Combine

@MainActor
final class LaunchViewModel: ObservableObject {
    @Published private(set) var isReady = false

    func runStartupJobs(_ jobs: () async -> Void) async {
        await jobs()
        isReady = true
    }
}
