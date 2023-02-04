//
//  NetworkManager.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import Foundation

enum NetworkError: Error {
    case failedToGetData
    case decodeError
    case urlError
}

enum AppGroupUrl: String {
    case tr = "https://rss.applemarketingtools.com/api/v2/tr/apps/top-free/50/apps.json"
    case us = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
    case en = "https://rss.applemarketingtools.com/api/v2/gb/apps/top-free/10/apps.json"
}
struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchSearchResults(
        with keyword: String,
        completion: @escaping (Result<SearchResultResponse, NetworkError>) -> Void
    ) {
        guard let urlString = "https://itunes.apple.com/search?term=\(keyword)&entity=software".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return completion(.failure(.urlError))
        }
        guard let url = URL(string: urlString) else {
            return completion(.failure(.urlError))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                completion(.failure(.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
    func fetchAppGroup(
        with url: AppGroupUrl,
        completion: @escaping (Result<AppGroup, NetworkError>) -> Void
    ) {
        guard let url = URL(string: url.rawValue) else {
            return completion(.failure(.urlError))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                completion(.failure(.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(AppGroup.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
    func fetchSocialApps(completion: @escaping (Result<[SocialApp], NetworkError>) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        guard let url = URL(string: urlString) else {
            return completion(.failure(.urlError))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                completion(.failure(.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode([SocialApp].self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
}
