//
//  NewsInteractor.swift
//  News
//
//  Created by Александр on 04.02.2023.
//

protocol NewsInteractorInputProtocol: AnyObject {
    init(presenter: NewsInteractorOutputProtocol)
    func provideNewsData(from news: String?)
}
protocol NewsInteractorOutputProtocol: AnyObject {
    func receiveNewsData(newsData: [NewsData])
}
class NewsInteractor: NewsInteractorInputProtocol {
    var networkService = NetworkService()
    unowned let presenter: NewsInteractorOutputProtocol
    
    required init(presenter: NewsInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideNewsData(from news: String?) {
        Task {
            do {
                let arrayOfNews = try await networkService.fetchData(news)
                var arrayOfNewsData: [NewsData] = []
                arrayOfNews.articles.forEach { newsArticle in
                    let newsData = NewsData(
                        title: newsArticle.title,
                        image: newsArticle.urlToImage,
                        description: newsArticle.description,
                        publishedAt: newsArticle.publishedAt,
                        sourceName: newsArticle.source?.name,
                        url: newsArticle.url)
                    arrayOfNewsData.append(newsData)
                }
                presenter.receiveNewsData(newsData: arrayOfNewsData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
