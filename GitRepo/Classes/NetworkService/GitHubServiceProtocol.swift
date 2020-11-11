//
//  NetworkServiceProtocol.swift
//  GitRepo
//
//  Created by Admin on 10.11.2020.
//

import Foundation
import RxSwift

protocol GitHubServiceProtocol: class {
    func getRepositoriesList(text: String?) -> Single<Repositories>
}
