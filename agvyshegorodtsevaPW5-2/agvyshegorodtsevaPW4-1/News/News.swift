//
//  NewStruct.swift
//  agvyshegorodtsevaPW5
//
//  Created by Алиса Вышегородцева on 23.10.2022.
//

import Foundation

struct Results: Decodable {
    let articles: [Post]
}

struct Post: Decodable, Identifiable {
    let title, description, url, urlToImage: String?
    let source: Source

    var id: String? {
        source.id
    }
}

struct Source: Decodable {
    let id: String?
}
