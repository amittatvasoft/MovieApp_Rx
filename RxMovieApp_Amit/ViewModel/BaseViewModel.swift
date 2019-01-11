//
//  BaseViewModel.swift
//  RxMovieApp_Amit
//
//  Created by mac104 on 1/10/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import RxSwift
import RxCocoa

class BaseViewModel {

    // Dispose Bag
    let disposeBag                    = DisposeBag()
    let alertDialog                   = PublishSubject<(String,String)>()
    let leftBarButtonDidTapped        = PublishSubject<Void>()
    let rightBarButtonDidTapped       = PublishSubject<Void>()
    let isLoading : ActivityIndicator = ActivityIndicator()


}

