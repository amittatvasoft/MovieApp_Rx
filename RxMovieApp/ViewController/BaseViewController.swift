//
//  BaseViewController.swift
//  RXMovieApp
//
//  Created by mac104 on 1/10/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class BaseViewController: UIViewController, ActivityIndicatorViewable,NavigationProtocol {

    let disposeBag = DisposeBag()
    private var baseViewModel: BaseViewModel?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func setupBindingForBaseViewModel(viewModel: BaseViewModel){
        self.baseViewModel = viewModel
        viewModel.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let `self` = self else { return }

                if isLoading {
                    self.showActivityIndicator()
                } else {
                    self.hideActivityIndicator()
                }
            })
            .disposed(by: disposeBag)

        viewModel.alertDialog.observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (title, message) in
                guard let `self` = self else {return}
                self.showAlertDialogue(title: title, message: message)
            }).disposed(by: disposeBag)
    }

    func leftBarButtonDidTapped() {
        baseViewModel?.leftBarButtonDidTapped.onNext(())
    }

    func rightBarButtonDidTapped() {
        baseViewModel?.rightBarButtonDidTapped.onNext(())
    }
}

@objc protocol NavigationProtocol {
    @objc func leftBarButtonDidTapped()
    @objc func rightBarButtonDidTapped()
}

extension NavigationProtocol where Self: BaseViewController{
    func configureNavigationWithTitle(leftTitle: String? = nil,leftButtonImage: UIImage? = nil , title: String, rightTitle: String? = nil, rightButtonImage: UIImage? = nil){
        self.navigationItem.title = title
        if leftTitle != nil{
            let leftButton = UIBarButtonItem.init(title: leftTitle, style: .plain, target: self, action: #selector(self.leftBarButtonDidTapped))
            leftButton.tintColor = .black
            self.navigationItem.leftBarButtonItem = leftButton
        }else if leftButtonImage != nil{
            let leftButton = UIBarButtonItem.init(image: leftButtonImage, style: .plain, target: self, action: #selector(self.leftBarButtonDidTapped))
            leftButton.tintColor = .black
            self.navigationItem.leftBarButtonItem = leftButton
        }else{
            let backButton = UIBarButtonItem()
            backButton.tintColor = .black
            backButton.title = "Back"
            self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        }
        if rightTitle != nil{
            let rightButton = UIBarButtonItem.init(title: rightTitle, style: .plain, target: self, action: #selector(self.rightBarButtonDidTapped))
            rightButton.tintColor = .black
            self.navigationItem.rightBarButtonItem = rightButton
        }else if rightButtonImage != nil{
            let rightButton = UIBarButtonItem.init(image: rightButtonImage, style: .plain, target: self, action: #selector(self.rightBarButtonDidTapped))
            rightButton.tintColor = .black
            self.navigationItem.rightBarButtonItem = rightButton
        }
    }
}
