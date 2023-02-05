//
//  NetworkService.swift
//  News
//
//  Created by Александр on 04.02.2023.
//

protocol NetworkServiceProtocol {
    func fetchData(from url: String) async throws -> [News]
}
class NetworkService: NetworkServiceProtocol {
    func fetchData(from url: String) async throws -> [News] {
        <#code#>
    }
    
}
