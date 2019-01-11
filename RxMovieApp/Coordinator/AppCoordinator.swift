//
//  AppCoordinator.swift
//  RXMovieApp
//
//  Created by mac104 on 1/9/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import UIKit
import RxSwift

final class AppCoordinator: Coordinator<Void> {
    private let navigationController : UINavigationController
    private let window               : UIWindow
            let dependencies         : AppDependency

    init(window:UIWindow, navigationController:UINavigationController) {
        self.window               = window
        self.navigationController = navigationController
        self.dependencies         = AppDependency(window : self.window)
    }

    override func start() -> Observable<Void> {
        // Show Movie list screen
        return showMovieList()
    }

    private func showMovieList() -> Observable<Void> {
        let rootCoordinator = RootCoordinator(navigationController: navigationController, dependencies: self.dependencies)
        return coordinate(to: rootCoordinator)
    }

    deinit {
        //plog(AppCoordinator.self)
    }


}


