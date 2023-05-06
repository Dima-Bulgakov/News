//
//  NewsTableViewCellViewModel.swift
//  News
//
//  Created by Dima on 06.05.2023.
//

import Foundation

// MARK: - NewsTableViewCellViewModel
class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}
