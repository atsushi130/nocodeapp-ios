//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public final class NoAuthorization: AuthorizationProvider {

    public static let provider = NoAuthorization()

    public func authorize() throws -> Credential {
        return EmptyCredential()
    }
}

struct EmptyCredential: Credential {
    func append(for headers: [String : String]) -> [String : String] {
        return headers
    }
}
