import Foundation
import UIKit
import Combine

public final class APIClient: APIClientProtocol {

    private let session: AuthorizedSession

    public init(session: AuthorizedSession) {
        self.session = session
    }

    public func request(_ request: Request) -> AnyPublisher<Response, URLError> {

        guard let urlRequest = request.urlRequest else {
            return Fail<Response, URLError>(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        switch urlRequest.cachePolicy {
        case .reloadIgnoringCacheData:
            // 常にリクエスト
            return self.request(urlRequest)

        case .returnCacheDataDontLoad:
            // キャッシュが存在しない場合には失敗とする
            if let cached = self.findCache(for: urlRequest) {
                return self.makeCacheResponsePublisher(from: cached)
            } else {
                return Fail<Response, URLError>(error: URLError(.cancelled))
                    .eraseToAnyPublisher()
            }

        default:
            // キャッシュが存在すれば利用し、なければリクエスト
            if let cached = self.findCache(for: urlRequest) {
                return self.makeCacheResponsePublisher(from: cached)
            } else {
                return self.request(urlRequest)
            }
        }
    }

    public func request(_ request: URLRequest) -> AnyPublisher<Response, URLError> {
        self.session
            .dataTask(for: request)
            .map(Response.init(data:urlResponse:))
            .eraseToAnyPublisher()
    }

    private func findCache(for request: URLRequest) -> CachedURLResponse? {
        return URLCache.shared.cachedResponse(for: request)
    }

    private func makeCacheResponsePublisher(from cached: CachedURLResponse) -> AnyPublisher<Response, URLError> {
        return Deferred {
            Future<Response, URLError> { subject in
                let response = Response(data: cached.data, urlResponse: cached.response)
                return subject(.success(response))
            }
        }
        .eraseToAnyPublisher()
    }
}
