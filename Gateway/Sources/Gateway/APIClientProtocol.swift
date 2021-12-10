import Foundation
import Combine

protocol APIClientProtocol {
    func request(_ request: Request) -> AnyPublisher<Response, URLError>
}
