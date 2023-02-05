//
//  NewsConfigurator.swift
//  News
//
//  Created by Александр on 04.02.2023.
//

protocol NewsConfiguratorInputProtocol {
    func configure(with view: NewsTableViewController)
}
class NewsConfigurator: NewsConfiguratorInputProtocol {
    func configure(with view: NewsTableViewController) {
        let presenter = NewsPresenter(view: view)
        let interactor = NewsInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
