//
//  AppDetailViewModel.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 18.02.2023.
//

import Foundation

typealias OnChange = (AppDetailModelState) -> Void

enum AppDetailModelState {
    case idle
    case loading(Bool)
    case success
    case failure(NetworkError)
}

final class AppDetailViewModel {
    
    var onChange: OnChange?
    let model: FeedResult
    
    var results: [SearchResult] = [] {
        didSet {
            emit(state: .success)
        }
    }
    
    init(model: FeedResult) {
        self.model = model
    }
    
    func fetchAppDetail() {
        guard let appId = model.id else { return }
        NetworkManager.shared.fetchAppDetail(id: appId) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.emit(state: .failure(error))
            case .success(let response):
                self?.results = response.results 
            }
        }
    }
    
    func emit(state: AppDetailModelState) {
        self.onChange?(state)
    }
}
