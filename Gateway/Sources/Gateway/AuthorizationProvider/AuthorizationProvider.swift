import Foundation

public protocol AuthorizationProvider {
    func authorize() throws -> Credential
}

public enum AuthorizationError: Error {
    case authorizeFailure
}
