//
//  AppDependency.swift
//  RxMovieApp_Amit
//
//  Created by mac104 on 1/9/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import UIKit

protocol HasWindow {
    var window: UIWindow { get }
}

protocol HasAPI {
    var api: API { get }
}

protocol HasSearchHistory {
    var searchHistory: SearchHistory { get }
}

class AppDependency: HasWindow, HasAPI, HasSearchHistory {
    let window        : UIWindow
    let api           : API
    let searchHistory : SearchHistory

    init(window: UIWindow) {
        self.window        = window
        self.api           = API.shared
        self.searchHistory = SearchHistory()
    }
}
