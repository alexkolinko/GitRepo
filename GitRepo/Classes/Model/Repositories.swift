//
//  Repositories.swift
//  GitRepo
//
//  Created by Admin on 10.11.2020.
//

import Foundation

struct Repositories: Codable {
    var items: [Repository]
}

struct Repository: Codable {
    var name: String
    var owner: Owner?
    var stargazers_count: Int
}

struct Owner: Codable {
    var avatar_url: String
}
