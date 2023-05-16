//
//  APICaller.swift
//  News
//
//  Created by Dima on 05.05.2023.
//

import Foundation

// MARK: - APICaller class
final class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let urlNews = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a12c4539f10a4cc18b688217e9c01999")
    }
    
    public func getNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.urlNews else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

// MARK: - Structs
struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
}
