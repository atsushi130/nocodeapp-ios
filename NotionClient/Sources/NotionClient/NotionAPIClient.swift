//
//  File.swift
//
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import Combine
import Gateway

public final class NotionAPIClient {

    private let client = APIClient(session: Session.create(authProvider: NotionAuthorization.provider)!)
    public static let shared = NotionAPIClient()

    private init() {}

    public func request<T: Object>(_ request: NotionRequest) -> AnyPublisher<NotionResponse<T>?, Never> {
        self.client.request(request)
            .map { response -> NotionResponse<T>? in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try! decoder.decode(NotionResponse<T>.self, from: response.data)
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
