//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public enum Session {
    public static func create(authProvider: AuthorizationProvider) -> AuthorizedSession? {
        guard let credential = try? authProvider.authorize() else { return nil }
        return AuthorizedSession(credential: credential)
    }
}
