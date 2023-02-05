//
//  NewsImageView.swift
//  News
//
//  Created by Александр on 05.02.2023.
//

import UIKit

class NewsImageView: UIImageView {
    func fetchImage(from urlString: String?) {
        guard let urlString = urlString else {
            image = UIImage(systemName: "person")
            return }
        guard let url = URL(string: urlString) else {
            image = UIImage(systemName: "person")
            return
        }
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        ImageManager.shared.fetchImage(from: url) { data, response in
            self.image = UIImage(data: data)
            self.saveDataToCache(with: data, and: response)
        }
    }
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
