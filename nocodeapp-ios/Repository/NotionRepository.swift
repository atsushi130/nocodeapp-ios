//
//  NotionRepository.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import Combine
import NotionClient

final class NotionRepository {

    private let client = NotionAPIClient.shared
    private let databaseId = "5169fc62c63145908e85dece44701861"

    func fetchLayouts() -> AnyPublisher<[Layout]?, Never> {
        return self.fetchLayoutDatabase()
            .map { response -> [Database<Layout>]? in
                if let response = response {
                    return response.results
                } else {
                    return nil
                }
            }
            .map { rows -> [Layout]? in
                if let rows = rows {
                    return rows.map { $0.properties }
                } else {
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }

    func fetchLayoutDatabase() -> AnyPublisher<NotionResponse<Database<Layout>>?, Never> {
        let request = Version1.Databases.Query(databaseId: self.databaseId)
        return self.client.request(request)
    }
}
