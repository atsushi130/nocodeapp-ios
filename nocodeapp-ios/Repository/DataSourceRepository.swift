//
//  DataSourceRepository.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import Gateway
import Combine

final class DataSourceRepository {

    private let client = APIClient.default

    func fetchDataSource<T: Decodable>(url: URL, type: T.Type) -> AnyPublisher<T?, Never> {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
        return self.client.request(request)
            .decode(T.self)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == Response, Failure == URLError {
    func decode<T: Decodable>(_ type: T.Type) -> AnyPublisher<T?, Error> {
        return self.tryMap { response in
            guard let httpURLResponse = response.urlResponse as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: response.data)
        }
        .eraseToAnyPublisher()
    }
}
