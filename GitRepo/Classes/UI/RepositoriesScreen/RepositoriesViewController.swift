//
//  RepositoriesViewController.swift
//  GitRepo
//
//  Created by Admin on 10.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesViewController: UIViewController {
    
    @IBOutlet weak var repoTable: UITableView!
    lazy var searchBar:UISearchBar = UISearchBar()
    var viewModel = RepositoriesViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
        RepoCell.register(to: repoTable)
        bindTableView()
        observeSearchBar()
    }
}

extension RepositoriesViewController {
    
    func setSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        navigationItem.titleView = searchBar
    }
    
    func bindTableView() {
        viewModel.searchRepositoriesList
            .bind(to: repoTable.rx.items(cellIdentifier: "RepoCell",
                                         cellType: RepoCell.self)) { (_, item, cell) in
                cell.updateUI(repository: item)}
            .disposed(by: disposeBag)
    }
    
    func observeSearchBar() {
        searchBar.rx.searchButtonClicked
            .map {[weak self] _ in
                self?.searchBar.resignFirstResponder()
                return self?.searchBar.text ?? "" }
            .distinctUntilChanged()
            .bind(to: viewModel.searchTextRelay )
            .disposed(by: disposeBag)
    }
    
    
    
    
}

