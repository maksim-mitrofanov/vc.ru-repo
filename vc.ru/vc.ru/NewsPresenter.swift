//
//  NewsPresenter.swift
//  vc.ru
//
//  Created by Максим Митрофанов on 02.10.2023.
//

import UIKit
import Foundation

protocol NewsPresenterProtocol {
    func receive(data: ServerFeedback?)
}

final class NewsPresenter: NewsPresenterProtocol {
    private(set) var presentedNews = [VCCellModel]()
    var delegate: NewsPresenterDelegate?
    
    func fetchLatestNews() {
        NetworkService.shared.presenter = self
        NetworkService.shared.fetchContent(with: presentedNews.last?.id)
    }
    
    func receive(data: ServerFeedback?) {
        let decodedNews = data?.result.news.map(convert(newsModel:))
        presentedNews.append(contentsOf: decodedNews ?? [])
        
        DispatchQueue.main.async {
            self.delegate?.newsWereUpdated()
        }
    }
}

private extension NewsPresenter {
    func convert(newsModel: ServerFeedback.NewsBlock) -> VCCellModel {
        let dummyImageData = UIImage(named: "demo_image")!.jpegData(compressionQuality: 1)!
        
        let model =  VCCellModel(
            subsiteImageData: nil,
            subsiteName: newsModel.subsite.name ,
            timeSincePublished: newsModel.date.description,
            title: newsModel.title,
            bodyText: "Error",
            mainImageData: dummyImageData,
            commentsCount: newsModel.counters.comments,
            repostsCount: newsModel.counters.reposts,
            votes: 0,
            id: newsModel.id.description
        )
        
        return model
    }
}

protocol NewsPresenterDelegate {
    func newsWereUpdated()
}
