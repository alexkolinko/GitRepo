//
//  RepositoriesViewModelsProtocol.swift
//  GitRepo
//
//  Created by Admin on 10.11.2020.
//

import Foundation
import RxSwift
import RxRelay

protocol RepositoriesViewModelProtocol: class {
    // MARK: - Input
    var searchTextRelay: BehaviorRelay<String> { get }
    
    // MARK: - Output
    var searchRepositoriesList: Observable<[Repository]> { get }
    var repositoriesResultRelay: BehaviorRelay<[Repository]> {get set}
}
