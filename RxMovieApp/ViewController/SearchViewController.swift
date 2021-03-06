//
//  SearchViewController.swift
//  RXMovieApp
//
//  Created by mac104 on 1/10/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {
    var viewModel: SearchViewModel!
    @IBOutlet weak private var tblHistory: UITableView!
    private lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.showsCancelButton = true
        if let txfSearchField = searchbar.value(forKey: "_searchField") as? UITextField {
            txfSearchField.borderStyle = .none
            txfSearchField.backgroundColor = .white
            txfSearchField.cornerRadius = 14
            txfSearchField.rx.controlEvent([.editingDidEndOnExit])
                .bind(to: viewModel.searchDidTapped)
                .disposed(by: disposeBag)
            txfSearchField.tintColor = UIColor.blue
        }
        searchbar.tintColor = UIColor.white
        return searchbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()

        tblHistory.tableFooterView = UIView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchBar.becomeFirstResponder()
    }
}

//MARK: - Setup
extension SearchViewController{
    private func setup(){
        self.setupUI()
        self.setupBinding(viewModel: self.viewModel)
    }

    private func setupUI(){
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 25/255.0, green:43/255.0, blue: 79/255.0, alpha: 1)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.titleView = searchBar
    }
    
    private func setupBinding(viewModel: SearchViewModel){
        super.setupBindingForBaseViewModel(viewModel: viewModel)
        self.searchBar.rx.cancelButtonClicked
            .bind(to: viewModel.dismiss)
            .disposed(by: disposeBag)
        self.searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchString)
            .disposed(by: disposeBag)
        self.viewModel.searchHistory
            .bind(to: tblHistory.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = element
                cell.textLabel?.textColor = UIColor.gray
            }.disposed(by: disposeBag)
        self.tblHistory.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
            guard let `self` = self else {return}
            self.viewModel.deleteElement(for: indexPath)
        }).disposed(by: disposeBag)

        self.tblHistory
            .rx
            .modelSelected(String.self)
            .bind(to: viewModel.selectedKeyword)
            .disposed(by: disposeBag)

    }
}
