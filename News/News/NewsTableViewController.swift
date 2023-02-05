//
//  NewsTableViewController.swift
//  News
//
//  Created by Александр on 04.02.2023.
//

import UIKit

protocol NewsViewInputProtocol: AnyObject {
    func setNews(_ news: [Article])
}

protocol NewsViewOutputProtocol {
    init(view: NewsViewInputProtocol)
    func didPullRefresh()
    func didSetNews(news: String?)
}

class NewsTableViewController: UITableViewController {
    var articles: [Article] = []
    var presenter: NewsViewOutputProtocol!
    private var timer: Timer?
    
    private let configurator: NewsConfiguratorInputProtocol = NewsConfigurator()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        configurator.configure(with: self)
        setupSearchBar()
    }

}
// MARK: - Setup View
private extension NewsTableViewController {
    func setTableView() {
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
    }
    func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.title = "Search news"
    }
}
// MARK: - UITableViewControllerDelegate, UITableViewControllerDataSource
extension NewsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let article = articles[indexPath.row]
        cell.configure(title: article.title, imageURL: article.urlToImage)
        return cell
    }
}
// MARK: - didSelectRowAt
extension NewsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        let descriptionVC = DescriptionViewController()
        present(descriptionVC, animated: true)
    }
}
// MARK: - NewsViewInputProtocol
extension NewsTableViewController: NewsViewInputProtocol {
    func setNews(_ news: [Article]) {
        articles = news
        DispatchQueue.main.async {
                self.tableView.reloadData()
        }
    }
}
// MARK: - UISearchBarDelegate
extension NewsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.presenter.didSetNews(news: searchText)
        })
    }
}
