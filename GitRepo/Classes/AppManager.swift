//
//  AppManager.swift
//  GitRepo
//
//  Created by Admin on 10.11.2020.
//

import Foundation


final class AppManager {
    static var shared = AppManager()
    private init() {}
    
    lazy var gitHubService: GitHubServiceProtocol = GitHubService()
}
