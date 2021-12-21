
import Foundation
import Combine

public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

@available(iOS 13.0, *)
public extension Publisher where Output: OptionalType {
    func filterNil() -> AnyPublisher<Output.Wrapped, Failure> {
        return self.flatMap { output -> AnyPublisher<Output.Wrapped, Failure> in
            if let output = output.optional {
                return Just(output).setFailureType(to: Failure.self).eraseToAnyPublisher()
            } else {
                return Empty<Output.Wrapped, Failure>().eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
}
