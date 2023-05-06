//
//  Model.swift
//  News
//
//  Created by Dima on 06.05.2023.
//

import Foundation

// MARK: - APIResponse
struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
}
