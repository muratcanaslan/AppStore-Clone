//
//  AppGroup.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed?
}

struct Feed: Decodable {
    let title: String?
    let results: [FeedResult]?
}

struct FeedResult: Decodable {
    let name, artistName: String?
    let artworkUrl100: URL?
    let id: String?
}
