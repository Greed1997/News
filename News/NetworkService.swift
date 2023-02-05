//
//  NetworkService.swift
//  News
//
//  Created by Александр on 04.02.2023.
//

import Foundation
enum NetworkErrors: String, Error {
    case invalidURL = "Wrong URL"
    case breakJSON = "JSON decode error"
}
protocol NetworkServiceProtocol {
    func fetchData(_ about: String?) async throws -> News
}
final class NetworkService: NetworkServiceProtocol {
    
    private let apiKey = "8f7912c1dfe04c16bf0982e90a21ad77"
    
    func fetchData(_ about: String?) async throws -> News {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(about ?? "bitcoin")&pageSize=20&apiKey=\(apiKey)") else
        {
            print(NetworkErrors.invalidURL.rawValue)
            throw NetworkErrors.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        guard let news = try? decoder.decode(News.self, from: data) else {
            print(NetworkErrors.breakJSON.rawValue)
            throw NetworkErrors.breakJSON
        }
        return news
    }
}
final class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL?, completion: @escaping(Data, URLResponse) -> Void) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}
