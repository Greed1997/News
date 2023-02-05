//
//  NewsPresenter.swift
//  News
//
//  Created by Александр on 04.02.2023.
//

struct NewsData {
    let title: String?
    let image: String?
    let description: String?
    let publishedAt: String?
    let sourceName: String?
    let url: String?
}
class NewsPresenter: NewsViewOutputProtocol {
    
    unowned var view: NewsViewInputProtocol
    var interactor: NewsInteractorInputProtocol!
    
    required init(view: NewsViewInputProtocol) {
        self.view = view
    }
    func didSetNews(news: String?) {
        interactor.provideNewsData(from: news)
    }
    
    func didPullRefresh() {
//        interactor.provideNewsData()
        
    }
    
}
// MARK: - NewsInteractorOutputProtocol
extension NewsPresenter: NewsInteractorOutputProtocol {
    func receiveNewsData(newsData: [NewsData]) {
        var arrayOfArticles: [Article] = []
        newsData.forEach { oneNewsData in
            let article = Article(
                source: Source(id: nil, name: "Source: \(oneNewsData.sourceName ?? "")"),
                author: nil,
                title: "Title: \(oneNewsData.title ?? "")",
                description: "Description: \(oneNewsData.description ?? "")",
                url: oneNewsData.url,
                urlToImage: oneNewsData.image,
                publishedAt: oneNewsData.publishedAt)
            arrayOfArticles.append(article)
        }
        view.setNews(arrayOfArticles)
    }
}
