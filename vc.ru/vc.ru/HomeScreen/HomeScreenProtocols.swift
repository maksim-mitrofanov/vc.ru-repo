//
//  HomeScreenViewInput.swift
//  vc.ru
//
//  Created by Максим Митрофанов on 26.02.2024.
//

import UIKit

protocol HomeScreenViewInput: AnyObject {
    func display(news: [NewsBlockModel])
}

protocol HomeScreenViewPresenter: AnyObject {
    func loadMoreData()
}

protocol NewsFeedNetworkService: AnyObject {
    func fetchNews(lastId: Int?, completion: @escaping ((ServerFeedback?) -> Void))
    func fetchAsset(uuid: String, completion: @escaping ((Data?) -> Void))
}

protocol NewsFeedNetworkServiceDelegate: AnyObject {
    func receiveNews(data: ServerFeedback?)
}

protocol NewsFeedViewCoordinator: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func show(news: [NewsBlockModel])
    var onPrefetchRequest: (() -> Void)? { get set }
}
