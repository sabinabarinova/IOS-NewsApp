//
//  NewsModel.swift
//  NewsApp
//
//  Created by Adil Meirambek on 09.04.2022.
//

import Foundation

struct NewsModel: Decodable {
    let articles: [Article]
}


struct Article: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title, author, description, url, urlToImage, publishedAt
    }
    
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.author = try container.decode(String.self, forKey: .author)
        self.description = try container.decode(String.self, forKey: .description)
        self.url = try container.decode(String.self, forKey: .url)
        self.urlToImage = try container.decode(String?.self, forKey: .urlToImage)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        
    }
    
    
}
