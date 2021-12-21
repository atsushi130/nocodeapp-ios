//
//  ImageView.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/13.
//

import Foundation
import UIKit
import Combine
import Gateway
import Extension

class ImageView: UIImageView {

    private var cancellable = Set<AnyCancellable>()
    private let client = APIClient.default

    var imageURL: URL? = nil {
        didSet {
            self.reset()
            guard let imageURL = self.imageURL else { return }
            self.fetchImage(url: imageURL)
                .filterNil()
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] image in
                    guard let self = self else { return }
                    self.image = image
                })
                .store(in: &self.cancellable)
        }
    }

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fetchImage(url: URL) -> AnyPublisher<UIImage?, Never> {
        self.request(imageURL: url)
            .flatMap { response -> AnyPublisher<UIImage?, Never> in
                if let response = response,
                   let urlResponse = response.urlResponse as? HTTPURLResponse,
                   urlResponse.statusCode == 200 {
                    // 正常系
                    let image = UIImage(data: response.data)
                    return Just(image).eraseToAnyPublisher()
                } else {
                    return Just(nil).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    private func request(imageURL: URL) -> AnyPublisher<Response?, Never> {
        let request = URLRequest(url: imageURL, cachePolicy: .reloadIgnoringCacheData)
        return self.client
            .request(request)
            .map { response -> Response? in
                return response
            }
            .catch { _ -> AnyPublisher<Response?, Never> in
                let response: Response? = nil
                return Just(response).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func reset() {
        self.image = nil
        self.cancelDownload()
    }

    func cancelDownload() {
        self.cancellable.forEach { $0.cancel() }
    }
}

