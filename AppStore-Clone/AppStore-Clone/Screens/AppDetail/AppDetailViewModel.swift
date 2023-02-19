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

enum AppDetailCellType {
    case information(model: SearchResult)
    case preview(model: [URL])
    case rating(model: [Entry])
}

final class AppDetailViewModel {
    
    var onChange: OnChange?
    let model: FeedResult
    
    var cells: [AppDetailCellType] = [] {
        didSet {
            emit(state: .success)
        }
    }
    
    init(model: FeedResult) {
        self.model = model
    }
    
    func fetchAppDetail() {
        
        emit(state: .loading(true))
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        guard let appId = model.id else {
            self.emit(state: .loading(false))
            return
        }
        NetworkManager.shared.fetchAppDetail(id: appId) { [weak self] result in
            dispatchGroup.leave()
            guard let self else { return }
            switch result {
            case .failure(let error):
                self.emit(state: .failure(error))
            case .success(let response):
                if let model = response.results.first {
                    self.cells.append(.information(model: model))
                    self.cells.append(.preview(model: self.screenshots(model: model)))
                }
            }
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.fetchReviews(id: appId) { [weak self] result in
            dispatchGroup.leave()
            switch result {
            case .failure(let error):
                self?.emit(state: .failure(error))
            case .success(let response):
                self?.cells.append(.rating(model: response.feed.entry))
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.emit(state: .loading(false))
        }
        
    }
    
    func emit(state: AppDetailModelState) {
        self.onChange?(state)
    }
    
    private func screenshots(model: SearchResult) -> [URL] {
        return model.screenshotUrls.compactMap({ $0 })
    }
}
