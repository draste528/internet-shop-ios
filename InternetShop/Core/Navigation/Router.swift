//
//  Router.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import Combine

@MainActor
final class Router<Route: Hashable>: ObservableObject {
    @Published var path: [Route] = []

    func push(_ route: Route) { path.append(route) }
    func pop() { guard !path.isEmpty else { return }; path.removeLast() }
    func popToRoot() { path.removeAll() }
}
