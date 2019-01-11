//
//  AppDelegate.swift
//  RxMovieApp_Amit
//
//  Created by mac104 on 1/9/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window         : UIWindow?
    var appCoordinator : AppCoordinator?
    let disposeBag = DisposeBag()

    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController

        // Initialise coordinator to manage navigation flow
        appCoordinator = AppCoordinator(window: window!, navigationController: navigationController)
        appCoordinator?.start()
            .subscribe()
            .disposed(by: disposeBag)
        window?.makeKeyAndVisible()

        return true
    }
}

