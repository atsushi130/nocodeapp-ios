//
//  ViewController.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private let repository = NotionRepository()
    private let dataSourceRepository = DataSourceRepository()
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.repository.fetchLayouts()
            .map { layouts -> [Layout] in
                guard let layouts = layouts else { return [] }
                return layouts.filter { layout in
                    layout.dataURL != nil
                }
            }
            .map { layouts -> Layout? in
                return layouts.first
            }
            .flatMap { layout -> AnyPublisher<[LayoutDataSource]?, Never> in
                if let layout = layout, let url = layout.dataURL?.url {
                    return self.dataSourceRepository.fetchJson(url: url, type: [LayoutDataSource].self)
                } else {
                    return Just(nil).eraseToAnyPublisher()
                }
            }
             .sink { json in
                print("*** json: \(json)")
            }
            .store(in: &self.cancellable)
    }


}

