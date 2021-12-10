//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import Gateway

public final class NotionAuthorization: AuthorizationProvider {

    public static let provider = NotionAuthorization()
    public var token: String?

    public func authorize() throws -> Credential {
        guard let token = self.token else {
            throw AuthorizationError.authorizeFailure
        }
        return KeyValueCredential(key: "Authorization", value: "Bearer \(token)")
    }
}
