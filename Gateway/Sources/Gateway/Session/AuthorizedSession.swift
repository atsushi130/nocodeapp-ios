//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public struct AuthorizedSession {

    private let `default` = URLSession(configuration: .default)
    private let credential: Credential

    init(credential: Credential) {
        self.credential = credential
    }

    func dataTask(for request: URLRequest) -> URLSession.DataTaskPublisher {
        let authorizedRequest = self.authorize(for: request)
        return self.default.dataTaskPublisher(for: authorizedRequest)
    }

    private func authorize(for request: URLRequest) -> URLRequest {
        var urlRequest = request
        let headers = request.allHTTPHeaderFields ?? [:]
        let authorizedHeaders = self.credential.append(for: headers)
        urlRequest.allHTTPHeaderFields = authorizedHeaders
        return urlRequest
    }
}
