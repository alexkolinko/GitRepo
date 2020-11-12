//
//  NetworkService.swift
//  GitRepo
//
//  Created by Admin on 10.11.2020.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

enum APIError: Error {
    case responseProblem(Data?, URLResponse?, Error?)
    case decodingProblem
    case encodingProblem
    case invalidInputData
}

final class GitHubService {
    fileprivate let ephemeralURLSession: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        return URLSession(configuration: config, delegate: nil, delegateQueue: .main)
    }()
    
}

extension GitHubService: GitHubServiceProtocol {
    func getRepositoriesList(text: String?) -> Single<Repositories> {
        guard let txt = text else {
            let error: APIError = .invalidInputData
            return Single.error(error)
        }
        let methodArguments: [String: AnyObject] = ["q": txt as AnyObject]
        let repoTitle: String = escapedParameters(methodArguments)
        let searchRepoByTitle = GitHubConstants.repositorySearchRequest(repoTitle)
        if let url = URL(string: searchRepoByTitle) {
            let request = URLRequest(url: url)
            return runDataTask(request: request)
        }
        let error: APIError = .invalidInputData
        return Single.error(error)
    }
}


extension GitHubService {
    
    func escapedParameters(_ parameters: [String: AnyObject]) -> String {
        var urlVars = [String]()
        for (key, value) in parameters {
            let stringValue = "\(value)"
            let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (!urlVars.isEmpty ? "" : "") + urlVars.joined(separator: "&")
    }
    
    func runDataTask(request: URLRequest) -> Single<Repositories> {
        return Single.create { single in
            let task = self.ephemeralURLSession.dataTask(with: request) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                      let jsondata = data else {
                    let error: APIError = .responseProblem(data, response, error)
                    single(.error(error))
                    return
                }
                if let obj = try? JSONDecoder().decode(Repositories.self, from: jsondata) {
                    single(.success(obj))
                    return
                }
                let error: APIError = .decodingProblem
                single(.error(error))
            }
            task.resume()
            return Disposables.create()
        }
    }
}
