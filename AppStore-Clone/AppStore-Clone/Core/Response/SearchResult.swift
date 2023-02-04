//
//  SearchResult.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import Foundation

struct SearchResultResponse: Decodable {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
}
