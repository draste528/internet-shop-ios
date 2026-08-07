//
//  BaseScreenViewModel.swift
//  InternetShop
//
//  Created by kair on 05.08.26.
//

import Foundation
import Combine

class BaseScreenViewModel: ObservableObject {
    let title: String
    init(title: String) {
        self.title = title
    }
}
