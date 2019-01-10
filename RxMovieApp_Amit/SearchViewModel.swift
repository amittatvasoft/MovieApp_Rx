//
//  SearchViewModel.swift
//  RxMovieApp_Amit
//
//  Created by mac104 on 1/10/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel{

    // Dependencies
    typealias Dependencies = HasSearchHistory
    private let dependencies: Dependencies

    //Data
    var searchHistory : Observable<[String]>
    var searchString  : BehaviorRelay<String> = BehaviorRelay(value: "")

    //Action
    var dismiss         = PublishSubject<Void>()
    var searchDidTapped = PublishSubject<Void>()

    init(dependencies: Dependencies){
        self.dependencies  = dependencies
        self.searchHistory = dependencies.searchHistory.arrKeyword.asObservable()
        super.init()
        self.searchDidTapped.asObservable().subscribe(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            if self.searchString.value.count > 0 {
                self.dependencies.searchHistory.insert(self.searchString.value)
            }
            self.searchString.accept("")
        }).disposed(by: self.disposeBag)
    }

    func deleteElement(for indexPath: IndexPath){
        if indexPath.row < self.dependencies.searchHistory.arrKeyword.value.count {
            self.dependencies.searchHistory.remove(self.dependencies.searchHistory.arrKeyword.value[indexPath.row])
        }
    }
}
