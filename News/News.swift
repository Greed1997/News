//
//  News.swift
//  News
//
//  Created by Александр on 04.02.2023.
//


struct News: Decodable {
    let articles: [Article]
}
struct Article: Decodable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
struct Source: Decodable {
    let id: String?
    let name: String?
}
