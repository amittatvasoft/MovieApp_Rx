//
//  RootCoordinator.swift
//  RXMovieApp
//
//  Created by mac104 on 1/10/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
import RxCocoa

class RootCoordinator: Coordinator<Void>{
    typealias Dependencies = HasWindow & HasAPI & HasSearchHistory

    private let navigationController : UINavigationController
    private let dependencies         : Dependencies

    init(navigationController:UINavigationController, dependencies: Dependencies) {
        self.navigationController = navigationController
        self.dependencies         = dependencies
    }

    override func start() -> Observable<CoordinationResult> {
        self.showHomeViewController()
        return Observable.never()
    }

    private func showHomeViewController(){
        let viewModel            = HomeViewModel.init(dependencies : self.dependencies)
        let viewController       = UIStoryboard.main.homeViewController
        viewController.viewModel = viewModel

        viewModel.rightBarButtonDidTapped.asObservable()
            .subscribe(onNext: {[weak self] _ in
                guard let `self` = self else {return}
                self.showSearchScreen()
            }).disposed(by: disposeBag)

        self.navigationController.pushViewController(viewController, animated: true)
    }

    private func showSearchScreen() {
        let viewModel            = SearchViewModel.init(dependencies : self.dependencies)
        let viewController       = UIStoryboard.main.searchViewConroller
        viewController.viewModel = viewModel
        let navVC = UINavigationController(rootViewController: viewController)
        viewModel.dismiss.asObservable()
            .subscribe(onNext: { 
                navVC.dismiss(animated: true, completion: nil)
            }).disposed(by: self.disposeBag)

        viewModel.searchDidTapped.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else {return}
                navVC.dismiss(animated: true, completion: {
                    self.showMovieListScreen(searchString: viewModel.searchString.value)
                })
            }).disposed(by: self.disposeBag)

        viewModel.selectedKeyword.asObservable()
            .subscribe(onNext: { [weak self] (keyword) in
                guard let `self` = self , let keyword = keyword else {return}
                navVC.dismiss(animated: true, completion: {
                    self.showMovieListScreen(searchString: keyword)
                })
            }).disposed(by: self.disposeBag)

        self.navigationController.visibleViewController?.present(navVC, animated: true, completion: nil)
    }

    private func showMovieListScreen(searchString: String){
        let movieListCoordinator = MovieListCoordinator.init(navigationController: self.navigationController, dependencies: self.dependencies, searchString: "")
        _ = coordinate(to: movieListCoordinator)
    }

    deinit {
        //plog(RootCoordinator.self)
    }
}
