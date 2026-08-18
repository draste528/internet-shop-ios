//
//  AppRouter.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import Combine

@MainActor
final class AppRouter: ObservableObject {
    @Published private(set) var route: AppRoute = .launch

    func showMain() { route = .main }
}