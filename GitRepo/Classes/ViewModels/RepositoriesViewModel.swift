//
//  RepositoriesViewModel.swift
//  GitRepo
//
//  Created by Admin on 10.11.2020.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class RepositoriesViewModel: RepositoriesViewModelProtocol {
    // MARK: - Input
    var searchTextRelay: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    // MARK: - Output
    var searchRepositoriesList: Observable<[Repository]>
    
    // MARK: - Internal instance
    var repositoriesResultRelay: BehaviorRelay<[Repository]> = BehaviorRelay<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - Service
    let gitHubService = AppManager.shared.gitHubService
    
    init() {
        self.searchRepositoriesList = repositoriesResultRelay
            .share(replay: 1, scope: .whileConnected)
        observeSearchText()
    }
}

private extension RepositoriesViewModel {
    
    func observeSearchText() {
        searchTextRelay
            .filter({ !$0.isEmpty })
            .flatMap({ [unowned gitHubService] txt -> Single<Repositories> in
                return gitHubService.getRepositoriesList(text: txt)
            })
            .map({$0.items})
            .bind(to: repositoriesResultRelay)
            .disposed(by: disposeBag)
    }
}

