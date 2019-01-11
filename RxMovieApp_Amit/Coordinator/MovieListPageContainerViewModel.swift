//
//  MovieListPageContainerViewModel.swift
//  RxMovieApp_Amit
//
//  Created by mac104 on 1/10/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import Foundation
import RxSwift

final class MovieListPageContainerViewModel: BaseViewModel {
    typealias Dependencies = HasAPI
    // Dependencies
    private let dependencies: Dependencies

    var viewControllers: [UIViewController] = []


    var selectedIndex: Variable<Int> = Variable(0)

    init(dependencies: Dependencies,viewControllers: [UIViewController]) {
        self.dependencies = dependencies
        self.viewControllers = viewControllers
        super.init()
    }
}
