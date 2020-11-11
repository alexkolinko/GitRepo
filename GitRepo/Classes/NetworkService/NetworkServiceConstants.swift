//
//  NetworkServiceConstants.swift
//  GitRepo
//
//  Created by Admin on 10.11.2020.
//

import Foundation

public enum GitHubError: Error {
    case error(error: String)
    case parametersNil
    case encodingFailed
    case misingURL
    case noData
}

struct GitHubConstants {
    static let sort = "&sort=stars"
    static let baseURL = "https://api.github.com/"
    static let search = "search/repositories?"
    static let language = "+language:assembly"
    static let order = "&order=desc"
}

extension GitHubConstants {
    static func videoSearchRequest(_ videoTitle: String) -> String {
        return baseURL
            + search
            + videoTitle
            + language
            + sort
            + order
    }
}
